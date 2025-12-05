import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_model.freezed.dart';
part 'post_model.g.dart';

@freezed
abstract class Post with _$Post {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Post({
    @JsonKey(name: "_id") required String id,
    required String title,
    required String description,
    required String image,
    required String userId,
    @Default(0) int likesCount,
    @Default(0) int commentsCount,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
