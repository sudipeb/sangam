import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangam/features/socialfeed/presentation/blocs/create_post_event.dart';
import 'package:sangam/features/socialfeed/presentation/blocs/create_post_state.dart';
import '../../domain/usecases/create_post_usecase.dart';


/// BLoC for create post functionality
class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  final CreatePostUseCase _createPostUseCase;

  CreatePostBloc(this._createPostUseCase) : super(CreatePostInitial()) {
    on<CreatePostRequested>(_onCreatePostRequested);
    on<CreatePostReset>(_onCreatePostReset);
  }

  Future<void> _onCreatePostRequested(
    CreatePostRequested event,
    Emitter<CreatePostState> emit,
  ) async {
    try {
      emit(CreatePostLoading());

      final post = await _createPostUseCase.call(
        title: event.title,
        description: event.description,
        image: event.image,
      );

      emit(CreatePostSuccess(post));
    } catch (e) {
      emit(CreatePostFailure(e.toString()));
    }
  }

  void _onCreatePostReset(
    CreatePostReset event,
    Emitter<CreatePostState> emit,
  ) {
    emit(CreatePostInitial());
  }
}
