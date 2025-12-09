import 'package:sangam/features/socialfeed/domain/entities/post_entity.dart';

abstract class CreatePostState {}

class CreatePostInitial extends CreatePostState {}

class CreatePostLoading extends CreatePostState {}

class CreatePostSuccess extends CreatePostState {
  final Post post;

  CreatePostSuccess(this.post);
}

class CreatePostFailure extends CreatePostState {
  final String message;

  CreatePostFailure(this.message);
}
