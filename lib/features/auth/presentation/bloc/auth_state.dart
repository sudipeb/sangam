import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sangam/features/auth/domain/entity/user.dart';
part 'auth_state.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.registerSuccess(User user) = _RegisterSuccess;
  const factory AuthState.loginSuccess(User user) = _LoginSuccess;
  const factory AuthState.failure(String message) = _Failure;
  const factory AuthState.formstate(bool obscurePassword, bool isAgreed) =
      _Form;
}

@freezed
abstract class ForgotPasswordState with _$ForgotPasswordState {
  const factory ForgotPasswordState.loading() = _ForgotPasswordLoading;
  const factory ForgotPasswordState.success(String resetPasswordToken) =
      _ForgotPasswordSuccess;
  const factory ForgotPasswordState.failure(String error) =
      _ForgotPasswordFailure;
}

@freezed
abstract class ResetPasswordState with _$ResetPasswordState {
  const factory ResetPasswordState.loading() = _ResetPasswordLoading;
  const factory ResetPasswordState.success(String message) =
      _ResetPasswordSuccess;
  const factory ResetPasswordState.failure(String error) =
      _ResetPasswordFailure;
}
