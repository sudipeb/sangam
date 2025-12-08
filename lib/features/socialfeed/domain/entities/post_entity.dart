/// Domain entity representing a social media post
class PostEntity {
  final String id;
  final String title;
  final String description;
  final String? image;
  final String userId;
  final String userName;
  final int likesCount;
  final int commentsCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  const PostEntity({
    required this.id,
    required this.title,
    required this.description,
    this.image,
    required this.userId,
    required this.userName,
    required this.likesCount,
    required this.commentsCount,
    required this.createdAt,
    required this.updatedAt,
  });
}
