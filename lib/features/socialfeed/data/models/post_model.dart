import '../../domain/entities/post_entity.dart';

/// Data model for Post that can be serialized from/to JSON
class PostModel {
  final String id;
  final String title;
  final String description;
  final String? image;
  final String userId;
  final int likesCount;
  final int commentsCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  const PostModel({
    required this.id,
    required this.title,
    required this.description,
    this.image,
    required this.userId,
    required this.likesCount,
    required this.commentsCount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'],
      userId: json['userId'] ?? '',
      likesCount: json['likesCount'] ?? 0,
      commentsCount: json['commentsCount'] ?? 0,
      createdAt: DateTime.parse(
        json['createdAt'] ?? DateTime.now().toIso8601String(),
      ),
      updatedAt: DateTime.parse(
        json['updatedAt'] ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'image': image,
      'userId': userId,
      'likesCount': likesCount,
      'commentsCount': commentsCount,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  /// Convert data model to domain entity
  PostEntity toEntity({String userName = ''}) {
    return PostEntity(
      id: id,
      title: title,
      description: description,
      image: image,
      userId: userId,
      userName: userName,
      likesCount: likesCount,
      commentsCount: commentsCount,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

/// Legacy alias for backwards compatibility
typedef Post = PostModel;
