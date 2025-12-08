import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_model.freezed.dart';
part 'post_model.g.dart';

///[PostModel]represents data structure of a post
///
///extends the [User] entity
@freezed
abstract class PostModel with _$PostModel {
  const factory PostModel({
    required String id,
    required String title,
    required String description,
    String? image,
    required String userId,
    required int likesCount,
    required int commentsCount,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _PostModel;

  /// Factory constructor to parse a JSON map into a [PostModel] object.
  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
}
