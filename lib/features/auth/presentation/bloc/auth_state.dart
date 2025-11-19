import 'package:sangam/features/auth/domain/entity/user.dart';

///provides the different possible states
abstract class AuthState {}

class AuthInitial extends AuthState {
  final bool obscurePassword;
  final bool isAgreed;
  AuthInitial({this.obscurePassword = true, this.isAgreed = false});
}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final User user;
  AuthSuccess({required this.user});
}

class AuthFailure extends AuthState {
  final String message;
  AuthFailure({required this.message});
}
