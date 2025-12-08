import '../entities/post_entity.dart';

/// Repository interface for post-related operations
abstract class PostRepository {
  /// Create a new post
  Future<PostEntity> createPost({
    required String title,
    required String description,
    String? image,
  });

  /// Fetch posts for the user's feed
  Future<List<PostEntity>> fetchFeeds({int page = 1, int limit = 20});

  /// Fetch all posts
  Future<List<PostEntity>> fetchAllPosts({int page = 1, int limit = 20});

  /// Edit an existing post
  Future<PostEntity> editPost({
    required String postId,
    String? title,
    String? description,
    String? image,
  });

  /// Delete a post
  Future<bool> deletePost(String postId);
}
