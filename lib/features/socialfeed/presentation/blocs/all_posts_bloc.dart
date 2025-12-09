import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/usecases/fetch_all_posts_usecase.dart';

/// Events for all posts
abstract class AllPostsEvent {}

class AllPostsFetchRequested extends AllPostsEvent {
  final int page;
  final int limit;

  AllPostsFetchRequested({this.page = 1, this.limit = 5});
}

/// Load more posts for pagination
class AllPostsLoadMore extends AllPostsEvent {}

class AllPostsRefresh extends AllPostsEvent {}

/// States for all posts
abstract class AllPostsState {}

class AllPostsInitial extends AllPostsState {}

class AllPostsLoading extends AllPostsState {}

class AllPostsLoadingMore extends AllPostsState {
  final List<Post> currentPosts;

  AllPostsLoadingMore(this.currentPosts);
}

class AllPostsSuccess extends AllPostsState {
  final List<Post> posts;
  final bool hasReachedMax;
  final int currentPage;

  AllPostsSuccess({
    required this.posts,
    this.hasReachedMax = false,
    this.currentPage = 1,
  });
}

class AllPostsFailure extends AllPostsState {
  final String message;

  AllPostsFailure(this.message);
}

/// BLoC for all posts functionality with pagination
class AllPostsBloc extends Bloc<AllPostsEvent, AllPostsState> {
  final FetchAllPostsUseCase _fetchAllPostsUseCase;
  int _currentPage = 1;
  final int _limit = 5;

  AllPostsBloc(this._fetchAllPostsUseCase) : super(AllPostsInitial()) {
    on<AllPostsFetchRequested>(_onAllPostsFetchRequested);
    on<AllPostsLoadMore>(_onAllPostsLoadMore);
    on<AllPostsRefresh>(_onAllPostsRefresh);
  }

  Future<void> _onAllPostsFetchRequested(
    AllPostsFetchRequested event,
    Emitter<AllPostsState> emit,
  ) async {
    try {
      emit(AllPostsLoading());
      _currentPage = 1;

      final posts = await _fetchAllPostsUseCase.call(
        page: event.page,
        limit: event.limit,
      );

      emit(
        AllPostsSuccess(
          posts: posts,
          hasReachedMax: posts.length < event.limit,
          currentPage: event.page,
        ),
      );
    } catch (e) {
      emit(AllPostsFailure(e.toString()));
    }
  }

  Future<void> _onAllPostsLoadMore(
    AllPostsLoadMore event,
    Emitter<AllPostsState> emit,
  ) async {
    final currentState = state;
    if (currentState is AllPostsSuccess && !currentState.hasReachedMax) {
      try {
        emit(AllPostsLoadingMore(currentState.posts));

        _currentPage++;
        final newPosts = await _fetchAllPostsUseCase.call(
          page: _currentPage,
          limit: _limit,
        );

        final allPosts = [...currentState.posts, ...newPosts];

        emit(
          AllPostsSuccess(
            posts: allPosts,
            hasReachedMax: newPosts.length < _limit,
            currentPage: _currentPage,
          ),
        );
      } catch (e) {
        emit(AllPostsFailure(e.toString()));
      }
    }
  }

  Future<void> _onAllPostsRefresh(
    AllPostsRefresh event,
    Emitter<AllPostsState> emit,
  ) async {
    try {
      emit(AllPostsLoading());
      _currentPage = 1;

      final posts = await _fetchAllPostsUseCase.call(page: 1, limit: _limit);

      emit(
        AllPostsSuccess(
          posts: posts,
          hasReachedMax: posts.length < _limit,
          currentPage: 1,
        ),
      );
    } catch (e) {
      emit(AllPostsFailure(e.toString()));
    }
  }
}
