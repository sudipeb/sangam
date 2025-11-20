/// Base class for all authentication-related events.
abstract class AuthEvent {}

/// Creates a new [LoginRequested] event with the provided [email] and [password].
class LoginRequested extends AuthEvent {
  final String email;
  final String password;
  LoginRequested(this.email, this.password);
}

/// Creates a new [RegisterRequested] event.
class RegisterRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;
  RegisterRequested(this.name, this.email, this.password);
}

class TogglePasswordVisibility extends AuthEvent {}

class ToggleAgreement extends AuthEvent {}

class ForgotPassword extends AuthEvent {
  final String email;
  ForgotPassword(this.email);
}

class ResetPasswordRequested extends AuthEvent {
  final String token;
  final String password;

  ResetPasswordRequested({required this.token, required this.password});
}
