import '../../domain/entities/post_entity.dart';
import '../../domain/repositories/post_repository.dart';
import '../datasource/post_remote_datasource.dart';

/// Implementation of the PostRepository
/// Delegates the actual API calls to the [PostRemoteDataSource].
class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource _remoteDataSource;

  PostRepositoryImpl(this._remoteDataSource);

  @override
  Future<Post> createPost({
    required String title,
    required String description,
    String? image,
  }) async {
    final response = await _remoteDataSource.createPost(
      title: title,
      description: description,
      image: image,
    );
    return response.post; // Extract the post from the response
  }

  @override
  Future<List<Post>> fetchFeeds({int page = 1, int limit = 20}) {
    return _remoteDataSource.fetchFeeds(page: page, limit: limit);
  }

  @override
  Future<List<Post>> fetchAllPosts({int page = 1, int limit = 20}) {
    return _remoteDataSource.fetchAllPosts(page: page, limit: limit);
  }

  @override
  Future<List<Post>> fetchAllPostsPaginated() {
    return _remoteDataSource.fetchAllPostsPaginated();
  }

  @override
  Future<Post> editPost({
    required String postId,
    String? title,
    String? description,
    String? image,
  }) {
    return _remoteDataSource.editPost(
      postId: postId,
      title: title ?? '',
      description: description ?? '',
      image: image,
    );
  }

  @override
  Future<bool> likePost(String postId) {
    return _remoteDataSource.likePost(postId);
  }

  @override
  Future<bool> unlikePost(String postId) {
    return _remoteDataSource.unlikePost(postId);
  }

  @override
  Future<bool> commentOnPost(String postId, String comment) {
    return _remoteDataSource.commentOnPost(postId, comment);
  }

  @override
  Future<bool> deletePost(String postId) {
    return _remoteDataSource.deletePost(postId);
  }
}
