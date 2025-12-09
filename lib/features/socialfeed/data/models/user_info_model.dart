import 'package:sangam/features/socialfeed/domain/entities/post_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_info_model.freezed.dart';
part 'user_info_model.g.dart';

/// [UserInfoModel] represents data structure of a post coming from the backend
///
/// implements the [UserInfo] entity
@freezed
abstract class UserInfoModel with _$UserInfoModel implements UserInfo {
  const factory UserInfoModel({required String id, required String name}) =
      _UserInfoModel;

  /// Factory constructor to parse a JSON map into a [PostModel] object.
  factory UserInfoModel.fromJson(Map<String, dynamic> json) =>
      _$UserInfoModelFromJson(json);
}
