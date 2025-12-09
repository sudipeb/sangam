import '../entities/post_entity.dart';
import '../repositories/post_repository.dart';

/// Use case for fetching all posts (paginated)
class FetchAllPostsUseCase {
  final PostRepository _repository;

  FetchAllPostsUseCase(this._repository);

  /// Fetch posts with pagination
  Future<List<Post>> call({int page = 1, int limit = 20}) {
    return _repository.fetchAllPosts(page: page, limit: limit);
  }

  /// Fetch ALL posts from all pages
  Future<List<Post>> fetchAllPaginated() {
    return _repository.fetchAllPostsPaginated();
  }
}
