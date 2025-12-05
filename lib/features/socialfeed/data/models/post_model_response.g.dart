// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CreatePostResponse _$CreatePostResponseFromJson(Map<String, dynamic> json) =>
    _CreatePostResponse(
      message: json['message'] as String,
      post: Post.fromJson(json['post'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreatePostResponseToJson(_CreatePostResponse instance) =>
    <String, dynamic>{'message': instance.message, 'post': instance.post};
