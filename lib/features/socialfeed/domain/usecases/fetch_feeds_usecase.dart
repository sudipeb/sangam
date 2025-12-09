import '../entities/post_entity.dart';
import '../repositories/post_repository.dart';

/// Use case for fetching posts for the user's feed
class FetchFeedsUseCase {
  final PostRepository _repository;

  FetchFeedsUseCase(this._repository);

  Future<List<Post>> call({int page = 1, int limit = 20}) {
    return _repository.fetchFeeds(page: page, limit: limit);
  }
}
