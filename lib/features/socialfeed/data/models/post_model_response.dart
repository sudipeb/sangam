import 'package:freezed_annotation/freezed_annotation.dart';
import 'post_model.dart';

part 'post_model_response.freezed.dart';
part 'post_model_response.g.dart';

@freezed
abstract class CreatePostResponse with _$CreatePostResponse {
  const factory CreatePostResponse({
    required String message,
    required Post post,
  }) = _CreatePostResponse;

  factory CreatePostResponse.fromJson(Map<String, dynamic> json) =>
      _$CreatePostResponseFromJson(json);
}
