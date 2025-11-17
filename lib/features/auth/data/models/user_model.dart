import 'package:sangam/features/auth/domain/entity/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel implements User {
  const factory UserModel({
    required String id,
    required String name,
    required String email,
    required String pasword,
  }) = _UserModel;
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
