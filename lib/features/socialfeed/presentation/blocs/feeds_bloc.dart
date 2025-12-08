import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/usecases/fetch_feeds_usecase.dart';

/// Events for feeds
abstract class FeedsEvent {}

class FeedsFetchRequested extends FeedsEvent {
  final int page;
  final int limit;

  FeedsFetchRequested({this.page = 1, this.limit = 20});
}

class FeedsRefresh extends FeedsEvent {}

/// States for feeds
abstract class FeedsState {}

class FeedsInitial extends FeedsState {}

class FeedsLoading extends FeedsState {}

class FeedsSuccess extends FeedsState {
  final List<PostEntity> posts;

  FeedsSuccess(this.posts);
}

class FeedsFailure extends FeedsState {
  final String message;

  FeedsFailure(this.message);
}

/// BLoC for feeds functionality
class FeedsBloc extends Bloc<FeedsEvent, FeedsState> {
  final FetchFeedsUseCase _fetchFeedsUseCase;

  FeedsBloc(this._fetchFeedsUseCase) : super(FeedsInitial()) {
    on<FeedsFetchRequested>(_onFeedsFetchRequested);
    on<FeedsRefresh>(_onFeedsRefresh);
  }

  Future<void> _onFeedsFetchRequested(
    FeedsFetchRequested event,
    Emitter<FeedsState> emit,
  ) async {
    try {
      emit(FeedsLoading());

      final posts = await _fetchFeedsUseCase.call(
        page: event.page,
        limit: event.limit,
      );

      emit(FeedsSuccess(posts));
    } catch (e) {
      emit(FeedsFailure(e.toString()));
    }
  }

  Future<void> _onFeedsRefresh(
    FeedsRefresh event,
    Emitter<FeedsState> emit,
  ) async {
    try {
      emit(FeedsLoading());

      final posts = await _fetchFeedsUseCase.call();

      emit(FeedsSuccess(posts));
    } catch (e) {
      emit(FeedsFailure(e.toString()));
    }
  }
}
