import 'post_model.dart';

/// Response model for create post API
class CreatePostResponse {
  final String message;
  final PostModel post;

  const CreatePostResponse({required this.message, required this.post});

  factory CreatePostResponse.fromJson(Map<String, dynamic> json) {
    return CreatePostResponse(
      message: json['message'] ?? '',
      post: PostModel.fromJson(json['post'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'post': post.toJson()};
  }
}
