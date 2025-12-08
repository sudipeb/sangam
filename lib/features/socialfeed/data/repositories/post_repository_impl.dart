import '../../domain/entities/post_entity.dart';
import '../../domain/repositories/post_repository.dart';
import '../datasource/post_remote_datasource.dart';
import '../models/post_model.dart';

/// Implementation of the PostRepository
class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource _remoteDataSource;

  PostRepositoryImpl(this._remoteDataSource);

  @override
  Future<PostEntity> createPost({
    required String title,
    required String description,
    String? image,
  }) async {
    final response = await _remoteDataSource.createPost(
      title: title,
      description: description,
      image: image,
    );

    // Convert the response to PostModel then to PostEntity
    final postModel = PostModel(
      id: response.post.id,
      title: response.post.title,
      description: response.post.description,
      image: response.post.image,
      userId: response.post.userId,
      likesCount: response.post.likesCount,
      commentsCount: response.post.commentsCount,
      createdAt: response.post.createdAt,
      updatedAt: response.post.updatedAt,
    );

    return postModel.toEntity();
  }

  @override
  Future<List<PostEntity>> fetchFeeds({int page = 1, int limit = 20}) async {
    final posts = await _remoteDataSource.fetchFeeds(page: page, limit: limit);
    return posts.map((post) => post.toEntity()).toList();
  }

  @override
  Future<List<PostEntity>> fetchAllPosts({int page = 1, int limit = 20}) async {
    final posts = await _remoteDataSource.fetchAllPosts(
      page: page,
      limit: limit,
    );
    return posts.map((post) => post.toEntity()).toList();
  }

  @override
  Future<PostEntity> editPost({
    required String postId,
    String? title,
    String? description,
    String? image,
  }) async {
    final post = await _remoteDataSource.editPost(
      postId: postId,
      title: title ?? '',
      description: description ?? '',
      image: image,
    );
    return post.toEntity();
  }

  @override
  Future<bool> deletePost(String postId) async {
    return await _remoteDataSource.deletePost(postId);
  }
}
