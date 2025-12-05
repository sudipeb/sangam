// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Post _$PostFromJson(Map<String, dynamic> json) => _Post(
  id: json['_id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  image: json['image'] as String,
  userId: json['user_id'] as String,
  likesCount: (json['likes_count'] as num?)?.toInt() ?? 0,
  commentsCount: (json['comments_count'] as num?)?.toInt() ?? 0,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$PostToJson(_Post instance) => <String, dynamic>{
  '_id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'image': instance.image,
  'user_id': instance.userId,
  'likes_count': instance.likesCount,
  'comments_count': instance.commentsCount,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
};
