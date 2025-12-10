import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/like_post.dart';
import '../../domain/usecases/unlike_post.dart';
import '../../domain/usecases/comment_on_post.dart';

/// Events for post actions (like, unlike, comment)
abstract class PostActionsEvent {}

class LikePostEvent extends PostActionsEvent {
  final String postId;
  LikePostEvent(this.postId);
}

class UnlikePostEvent extends PostActionsEvent {
  final String postId;
  UnlikePostEvent(this.postId);
}

class CommentOnPostEvent extends PostActionsEvent {
  final String postId;
  final String comment;
  CommentOnPostEvent(this.postId, this.comment);
}

/// States for post actions
abstract class PostActionsState {}

class PostActionsInitial extends PostActionsState {}

class PostActionsLoading extends PostActionsState {
  final String postId;
  final String action; // 'like', 'unlike', 'comment'
  PostActionsLoading(this.postId, this.action);
}

class PostActionsSuccess extends PostActionsState {
  final String postId;
  final String action;
  final String message;
  PostActionsSuccess(this.postId, this.action, this.message);
}

class PostActionsFailure extends PostActionsState {
  final String postId;
  final String action;
  final String error;
  PostActionsFailure(this.postId, this.action, this.error);
}

/// BLoC for handling post actions like like, unlike, comment
class PostActionsBloc extends Bloc<PostActionsEvent, PostActionsState> {
  final LikePostUseCase _likePostUseCase;
  final UnlikePostUseCase _unlikePostUseCase;
  final CommentOnPostUseCase _commentOnPostUseCase;

  PostActionsBloc({
    required LikePostUseCase likePostUseCase,
    required UnlikePostUseCase unlikePostUseCase,
    required CommentOnPostUseCase commentOnPostUseCase,
  }) : _likePostUseCase = likePostUseCase,
       _unlikePostUseCase = unlikePostUseCase,
       _commentOnPostUseCase = commentOnPostUseCase,
       super(PostActionsInitial()) {
    on<LikePostEvent>(_onLikePost);
    on<UnlikePostEvent>(_onUnlikePost);
    on<CommentOnPostEvent>(_onCommentOnPost);
  }

  Future<void> _onLikePost(
    LikePostEvent event,
    Emitter<PostActionsState> emit,
  ) async {
    try {
      emit(PostActionsLoading(event.postId, 'like'));

      final success = await _likePostUseCase.call(event.postId);

      if (success) {
        emit(
          PostActionsSuccess(event.postId, 'like', 'Post liked successfully'),
        );
      } else {
        emit(PostActionsFailure(event.postId, 'like', 'Failed to like post'));
      }
    } catch (e) {
      emit(PostActionsFailure(event.postId, 'like', e.toString()));
    }
  }

  Future<void> _onUnlikePost(
    UnlikePostEvent event,
    Emitter<PostActionsState> emit,
  ) async {
    try {
      emit(PostActionsLoading(event.postId, 'unlike'));

      final success = await _unlikePostUseCase.call(event.postId);

      if (success) {
        emit(
          PostActionsSuccess(
            event.postId,
            'unlike',
            'Post unliked successfully',
          ),
        );
      } else {
        emit(
          PostActionsFailure(event.postId, 'unlike', 'Failed to unlike post'),
        );
      }
    } catch (e) {
      emit(PostActionsFailure(event.postId, 'unlike', e.toString()));
    }
  }

  Future<void> _onCommentOnPost(
    CommentOnPostEvent event,
    Emitter<PostActionsState> emit,
  ) async {
    try {
      emit(PostActionsLoading(event.postId, 'comment'));

      final success = await _commentOnPostUseCase.call(
        event.postId,
        event.comment,
      );

      if (success) {
        emit(
          PostActionsSuccess(
            event.postId,
            'comment',
            'Comment added successfully',
          ),
        );
      } else {
        emit(
          PostActionsFailure(event.postId, 'comment', 'Failed to add comment'),
        );
      }
    } catch (e) {
      emit(PostActionsFailure(event.postId, 'comment', e.toString()));
    }
  }
}
