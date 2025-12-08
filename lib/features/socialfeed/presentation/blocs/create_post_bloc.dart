import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/usecases/create_post_usecase.dart';

/// Events for create post
abstract class CreatePostEvent {}

class CreatePostRequested extends CreatePostEvent {
  final String title;
  final String description;
  final String? image;

  CreatePostRequested({
    required this.title,
    required this.description,
    this.image,
  });
}

class CreatePostReset extends CreatePostEvent {}

/// States for create post
abstract class CreatePostState {}

class CreatePostInitial extends CreatePostState {}

class CreatePostLoading extends CreatePostState {}

class CreatePostSuccess extends CreatePostState {
  final PostEntity post;

  CreatePostSuccess(this.post);
}

class CreatePostFailure extends CreatePostState {
  final String message;

  CreatePostFailure(this.message);
}

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
