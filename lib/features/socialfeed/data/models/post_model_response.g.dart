// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreatePostResponseModel _$CreatePostResponseModelFromJson(
  Map<String, dynamic> json,
) => _CreatePostResponseModel(
  message: json['message'] as String,
  post: PostModel.fromJson(json['post'] as Map<String, dynamic>),
);

Map<String, dynamic> _$CreatePostResponseModelToJson(
  _CreatePostResponseModel instance,
) => <String, dynamic>{'message': instance.message, 'post': instance.post};
