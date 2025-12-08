import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sangam/features/socialfeed/data/models/post_model.dart';
part 'post_model_response.freezed.dart';
part 'post_model_response.g.dart';

@freezed
abstract class CreatePostResponseModel with _$CreatePostResponseModel {
  const factory CreatePostResponseModel({
    required String message,
    required PostModel post,
  }) = _CreatePostResponseModel;
  factory CreatePostResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CreatePostResponseModelFromJson(json);
}
