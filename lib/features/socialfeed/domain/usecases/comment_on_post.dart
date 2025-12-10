import 'package:sangam/features/socialfeed/domain/repositories/post_repository.dart';

/// Use case for commenting on a post
class CommentOnPostUseCase {
  final PostRepository _repository;

  const CommentOnPostUseCase(this._repository);

  Future<bool> call(String postId, String comment) {
    return _repository.commentOnPost(postId, comment);
  }
}
