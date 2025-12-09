import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/usecases/fetch_feeds_usecase.dart';

/// Events for feeds
abstract class FeedsEvent {}

class FeedsFetchRequested extends FeedsEvent {
  final int page;
  final int limit;

  FeedsFetchRequested({this.page = 1, this.limit = 5});
}

/// Load more posts for pagination
class FeedsLoadMore extends FeedsEvent {}

class FeedsRefresh extends FeedsEvent {}

/// States for feeds
abstract class FeedsState {}

class FeedsInitial extends FeedsState {}

class FeedsLoading extends FeedsState {}

class FeedsLoadingMore extends FeedsState {
  final List<Post> currentPosts;

  FeedsLoadingMore(this.currentPosts);
}

class FeedsSuccess extends FeedsState {
  final List<Post> posts;
  final bool hasReachedMax;
  final int currentPage;

  FeedsSuccess({
    required this.posts,
    this.hasReachedMax = false,
    this.currentPage = 1,
  });
}

class FeedsFailure extends FeedsState {
  final String message;

  FeedsFailure(this.message);
}

/// BLoC for feeds functionality with pagination
class FeedsBloc extends Bloc<FeedsEvent, FeedsState> {
  final FetchFeedsUseCase _fetchFeedsUseCase;
  int _currentPage = 1;
  final int _limit = 5;

  FeedsBloc(this._fetchFeedsUseCase) : super(FeedsInitial()) {
    on<FeedsFetchRequested>(_onFeedsFetchRequested);
    on<FeedsLoadMore>(_onFeedsLoadMore);
    on<FeedsRefresh>(_onFeedsRefresh);
  }

  Future<void> _onFeedsFetchRequested(
    FeedsFetchRequested event,
    Emitter<FeedsState> emit,
  ) async {
    try {
      emit(FeedsLoading());
      _currentPage = 1;

      final posts = await _fetchFeedsUseCase.call(
        page: event.page,
        limit: event.limit,
      );

      emit(
        FeedsSuccess(
          posts: posts,
          hasReachedMax: posts.length < event.limit,
          currentPage: event.page,
        ),
      );
    } catch (e) {
      emit(FeedsFailure(e.toString()));
    }
  }

  Future<void> _onFeedsLoadMore(
    FeedsLoadMore event,
    Emitter<FeedsState> emit,
  ) async {
    final currentState = state;
    if (currentState is FeedsSuccess && !currentState.hasReachedMax) {
      try {
        emit(FeedsLoadingMore(currentState.posts));

        _currentPage++;
        final newPosts = await _fetchFeedsUseCase.call(
          page: _currentPage,
          limit: _limit,
        );

        final allPosts = [...currentState.posts, ...newPosts];

        emit(
          FeedsSuccess(
            posts: allPosts,
            hasReachedMax: newPosts.length < _limit,
            currentPage: _currentPage,
          ),
        );
      } catch (e) {
        emit(FeedsFailure(e.toString()));
      }
    }
  }

  Future<void> _onFeedsRefresh(
    FeedsRefresh event,
    Emitter<FeedsState> emit,
  ) async {
    try {
      emit(FeedsLoading());
      _currentPage = 1;

      final posts = await _fetchFeedsUseCase.call(page: 1, limit: _limit);

      emit(
        FeedsSuccess(
          posts: posts,
          hasReachedMax: posts.length < _limit,
          currentPage: 1,
        ),
      );
    } catch (e) {
      emit(FeedsFailure(e.toString()));
    }
  }
}
