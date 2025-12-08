import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangam/core/di/service_locator.dart';
import 'package:sangam/features/socialfeed/presentation/pages/create_post_page.dart';
import 'package:sangam/features/socialfeed/presentation/blocs/feeds_bloc.dart';

class SocialFeedPageClean extends StatelessWidget {
  const SocialFeedPageClean({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<FeedsBloc>()..add(FeedsFetchRequested()),
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
                      onPressed: () =>
                          context.read<FeedsBloc>().add(FeedsRefresh()),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            if (state is FeedsSuccess) {
              final posts = state.posts;
              if (posts.isEmpty) {
                return const Center(child: Text('No posts yet'));
              }

              return RefreshIndicator(
                onRefresh: () async {
                  context.read<FeedsBloc>().add(FeedsRefresh());
                },
                child: ListView.separated(
                  padding: const EdgeInsets.all(12),
                  itemCount: posts.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, i) {
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
                                    post.userName.isNotEmpty
                                        ? post.userName[0].toUpperCase()
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
                                        post.userName.isNotEmpty
                                            ? post.userName
                                            : 'Unknown User',
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
