import 'package:sangam/features/socialfeed/domain/repositories/post_repository.dart';

/// Use case for liking a post
class LikePostUseCase {
  final PostRepository _repository;

  const LikePostUseCase(this._repository);

  Future<bool> call(String postId) {
    return _repository.likePost(postId);
  }
}
