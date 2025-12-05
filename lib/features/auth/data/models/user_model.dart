import 'package:sangam/features/auth/domain/entity/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_model.freezed.dart';
part 'user_model.g.dart';

///[UserModel]representsdata structure of a user coming from the backend
///
///extends the [User] entity
@freezed
abstract class UserModel with _$UserModel implements User {
  const factory UserModel({
    required String id,
    required String name,
    required String email,
    String? password,
  }) = _UserModel;

  /// Factory constructor to parse a JSON map into a [UserModel] object.
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
  