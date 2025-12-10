import 'package:sangam/features/socialfeed/domain/repositories/post_repository.dart';

/// Use case for unliking a post
class UnlikePostUseCase {
  final PostRepository _repository;

  const UnlikePostUseCase(this._repository);

  Future<bool> call(String postId) {
    return _repository.unlikePost(postId);
  }
}
