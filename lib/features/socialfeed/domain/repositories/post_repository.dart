import '../entities/post_entity.dart';

/// Repository interface for post-related operations
abstract class PostRepository {
  /// Create a new post
  Future<Post> createPost({
    required String title,
    required String description,
    String? image,
  });

  /// Fetch posts for the user's feed
  Future<List<Post>> fetchFeeds({int page = 1, int limit = 20});

  /// Fetch all posts
  Future<List<Post>> fetchAllPosts({int page = 1, int limit = 20});

  /// Fetch ALL posts from all pages (complete dataset)
  Future<List<Post>> fetchAllPostsPaginated();

  /// Edit an existing post
  Future<Post> editPost({
    required String postId,
    String? title,
    String? description,
    String? image,
  });

  /// Delete a post
  Future<bool> deletePost(String postId);
}
