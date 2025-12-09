import '../entities/post_entity.dart';
import '../repositories/post_repository.dart';

/// Use case for creating a new post
class CreatePostUseCase {
  final PostRepository _repository;

  CreatePostUseCase(this._repository);

  Future<Post> call({
    required String title,
    required String description,
    String? image,
  }) {
    return _repository.createPost(
      title: title,
      description: description,
      image: image,
    );
  }
}
