import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangam/core/di/service_locator.dart';
import 'package:sangam/features/socialfeed/presentation/pages/create_post_page.dart';
import 'package:sangam/features/socialfeed/presentation/blocs/feeds_bloc.dart';
import 'package:sangam/features/socialfeed/presentation/blocs/post_actions_bloc.dart';

class SocialFeedPageClean extends StatefulWidget {
  const SocialFeedPageClean({super.key});

  @override
  State<SocialFeedPageClean> createState() => _SocialFeedPageCleanState();
}

class _SocialFeedPageCleanState extends State<SocialFeedPageClean> {
  final ScrollController _scrollController = ScrollController();
  late FeedsBloc _feedsBloc;

  @override
  void initState() {
    super.initState();
    _feedsBloc = getIt<FeedsBloc>()..add(FeedsFetchRequested());
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _feedsBloc.close();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      _feedsBloc.add(FeedsLoadMore());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void _showCommentDialog(BuildContext context, String postId) {
    final TextEditingController commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Add Comment'),
          content: TextField(
            controller: commentController,
            decoration: const InputDecoration(
              hintText: 'Write your comment...',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            BlocConsumer<PostActionsBloc, PostActionsState>(
              listener: (context, state) {
                if (state is PostActionsSuccess && state.action == 'comment') {
                  Navigator.of(dialogContext).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else if (state is PostActionsFailure &&
                    state.action == 'comment') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                final isCommenting =
                    state is PostActionsLoading &&
                    state.action == 'comment' &&
                    state.postId == postId;

                return ElevatedButton(
                  onPressed: isCommenting
                      ? null
                      : () {
                          if (commentController.text.trim().isNotEmpty) {
                            context.read<PostActionsBloc>().add(
                              CommentOnPostEvent(
                                postId,
                                commentController.text.trim(),
                              ),
                            );
                          }
                        },
                  child: isCommenting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Comment'),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FeedsBloc>.value(value: _feedsBloc),
        BlocProvider<PostActionsBloc>(
          create: (context) => getIt<PostActionsBloc>(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Social Feed'),
          actions: [
            IconButton(
              tooltip: 'Create Post',
              icon: const Icon(Icons.add),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const CreatePostPageClean()),
              ),
            ),
          ],
        ),
        body: BlocBuilder<FeedsBloc, FeedsState>(
          builder: (context, state) {
            if (state is FeedsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is FeedsFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: ${state.message}'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => _feedsBloc.add(FeedsRefresh()),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            if (state is FeedsSuccess || state is FeedsLoadingMore) {
              final posts = state is FeedsSuccess
                  ? state.posts
                  : (state as FeedsLoadingMore).currentPosts;

              final hasReachedMax = state is FeedsSuccess
                  ? state.hasReachedMax
                  : false;
              if (posts.isEmpty) {
                return const Center(child: Text('No posts yet'));
              }

              return RefreshIndicator(
                onRefresh: () async {
                  _feedsBloc.add(FeedsRefresh());
                },
                child: ListView.separated(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(12),
                  itemCount: posts.length + (hasReachedMax ? 0 : 1),
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, i) {
                    if (i >= posts.length) {
                      // Show loading indicator at the bottom
                      return const Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    final post = posts[i];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  child: Text(
                                    post.userinfo?.name.isNotEmpty == true
                                        ? post.userinfo!.name[0].toUpperCase()
                                        : 'U',
                                  ),
                                ),

                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        post.userinfo?.name ?? 'Unknown User',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleSmall,
                                      ),
                                      Text(
                                        '${post.createdAt.day}/${post.createdAt.month}/${post.createdAt.year}',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodySmall,
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () =>
                                          Text("Followed the user"),
                                      icon: Icon(Icons.group_add),
                                      tooltip: 'Follow',
                                    ),
                                    const SizedBox(width: 10),
                                    IconButton(
                                      onPressed: () =>
                                          Text("Followed the user"),
                                      icon: Icon(Icons.more_vert),
                                      tooltip: 'Follow',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              post.title,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 8),
                            Text(post.description),
                            if (post.image != null &&
                                post.image!.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  post.image!,
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      height: 200,
                                      color: Colors.grey[300],
                                      child: const Icon(Icons.error),
                                    );
                                  },
                                ),
                              ),
                            ],
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                BlocListener<PostActionsBloc, PostActionsState>(
                                  listener: (context, state) {
                                    if (state is PostActionsSuccess) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(state.message),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                    } else if (state is PostActionsFailure) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(state.error),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  },
                                  child: BlocBuilder<PostActionsBloc, PostActionsState>(
                                    builder: (context, state) {
                                      final isLiking =
                                          state is PostActionsLoading &&
                                          state.postId == post.id;
                                      return Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            onPressed: isLiking
                                                ? null
                                                : () {
                                                    if (post.isLiked) {
                                                      context
                                                          .read<
                                                            PostActionsBloc
                                                          >()
                                                          .add(
                                                            UnlikePostEvent(
                                                              post.id,
                                                            ),
                                                          );
                                                    } else {
                                                      context
                                                          .read<
                                                            PostActionsBloc
                                                          >()
                                                          .add(
                                                            LikePostEvent(
                                                              post.id,
                                                            ),
                                                          );
                                                    }
                                                  },
                                            icon: isLiking
                                                ? SizedBox(
                                                    width: 20,
                                                    height: 20,
                                                    child:
                                                        CircularProgressIndicator(
                                                          strokeWidth: 2,
                                                        ),
                                                  )
                                                : Icon(
                                                    post.isLiked
                                                        ? Icons.thumb_up
                                                        : Icons
                                                              .thumb_up_outlined,
                                                    color: post.isLiked
                                                        ? Colors.blue
                                                        : null,
                                                  ),
                                          ),
                                          Text(
                                            '${post.likesCount}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  color: post.isLiked
                                                      ? Colors.blue
                                                      : null,
                                                ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        _showCommentDialog(context, post.id);
                                      },
                                      icon: const Icon(Icons.comment_outlined),
                                    ),
                                    Text(
                                      '${post.commentsCount}',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
            return const Center(child: Text('Something went wrong'));
          },
        ),
      ),
    );
  }
}
