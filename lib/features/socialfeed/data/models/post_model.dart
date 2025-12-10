import 'package:sangam/features/socialfeed/data/models/user_info_model.dart';
import 'package:sangam/features/socialfeed/domain/entities/post_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_model.freezed.dart';
part 'post_model.g.dart';

/// [PostModel] represents data structure of a post coming from the backend
///
/// implements the [Post] entity
@freezed
abstract class PostModel with _$PostModel implements Post {
  const factory PostModel({
    required String id,
    required String title,
    required String description,
    String? image,
    required String userId,
    required int likesCount,
    required int commentsCount,
    @Default(false) bool isLiked,
    required DateTime createdAt,
    required DateTime updatedAt,
    UserInfoModel? userinfo,
  }) = _PostModel;

  /// Factory constructor to parse a JSON map into a [PostModel] object.
  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
}
