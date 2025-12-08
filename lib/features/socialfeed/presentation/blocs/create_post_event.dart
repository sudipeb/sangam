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
