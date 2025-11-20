import 'package:sangam/features/auth/domain/entity/user.dart';

///provides the different possible states
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final User user;
  AuthSuccess({required this.user});
}

class AuthFailure extends AuthState {
  final String message;
  AuthFailure({required this.message});
}

class AuthFormState extends AuthState {
  final bool obscurePassword;
  final bool isAgreed;

  AuthFormState({this.obscurePassword = true, this.isAgreed = false});
}

///Forgot Password states
class ForgotPasswordLoading extends AuthState {}

class ForgotPasswordSuccess extends AuthState {
  final String resetPasswordToken;
  ForgotPasswordSuccess(this.resetPasswordToken);
}

class ForgotPasswordFailure extends AuthState {
  final String error;
  ForgotPasswordFailure(this.error);
}

//reset password
class ResetPasswordLoading extends AuthState {}

class ResetPasswordSuccess extends AuthState {
  final String message;
  ResetPasswordSuccess(this.message);
}

class ResetPasswordFailure extends AuthState {
  final String error;
  ResetPasswordFailure(this.error);
}
