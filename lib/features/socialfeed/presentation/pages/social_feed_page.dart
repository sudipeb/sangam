import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangam/core/di/service_locator.dart';
import 'package:sangam/features/socialfeed/presentation/pages/create_post_page.dart';
import 'package:sangam/features/socialfeed/presentation/blocs/feeds_bloc.dart';

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

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FeedsBloc>.value(
      value: _feedsBloc,
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
                                Icon(Icons.favorite_border, size: 20),
                                const SizedBox(width: 4),
                                Text('${post.likesCount}'),
                                const SizedBox(width: 16),
                                Icon(Icons.comment_outlined, size: 20),
                                const SizedBox(width: 4),
                                Text('${post.commentsCount}'),
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
