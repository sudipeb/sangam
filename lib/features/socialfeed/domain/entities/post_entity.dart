/// Domain entity representing a social media post
abstract class Post {
  final String id;
  final String title;
  final String description;
  final String? image;
  final String userId;
  final int likesCount;
  final int commentsCount;
  final bool isLiked;
  final DateTime createdAt;
  final DateTime updatedAt;
  final UserInfo? userinfo;

  const Post({
    required this.id,
    required this.title,
    required this.description,
    this.image,
    required this.userId,
    required this.likesCount,
    required this.commentsCount,
    this.isLiked = false,
    required this.createdAt,
    required this.updatedAt,
    this.userinfo,
  });
}

abstract class UserInfo {
  final String id;
  final String name;
  UserInfo({required this.id, required this.name});
}
