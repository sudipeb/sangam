import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangam/core/network/network_exceptions.dart';
import 'package:sangam/features/auth/domain/usecase/forgot_password.dart';
import 'package:sangam/features/auth/domain/usecase/login_user.dart';
import 'package:sangam/features/auth/domain/usecase/register_user.dart';
import 'package:sangam/features/auth/domain/usecase/reset_password.dart';
import 'package:sangam/features/auth/presentation/bloc/auth_event.dart';
import 'package:sangam/features/auth/presentation/bloc/auth_state.dart';

///[Bloc] to handle authentication logic
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUser loginUser;
  final RegisterUser registerUser;
  AuthBloc({required this.loginUser, required this.registerUser})
    : super(AuthState.initial()) {
    // Handler for LoginRequested event
    on<LoginRequested>((event, emit) async {
      emit(AuthState.loading());
      try {
        final user = await loginUser.execute(event.email, event.password);
        emit(AuthState.success(user));
      } catch (e) {
        if (e is NetworkExceptions) {
          emit(AuthState.failure(e.message));
        } else {
          emit(AuthState.failure(e.toString()));
        }
      }
    });
    // Handler for RegisterRequested event
    on<RegisterRequested>((event, emit) async {
      emit(AuthState.loading());
      try {
        final user = await registerUser.execute(
          event.name,
          event.email,
          event.password,
        );
        emit(AuthState.success(user));
      } catch (e) {
        if (e is NetworkExceptions) {
          emit(AuthState.failure(e.message));
        } else {
          emit(AuthState.failure(e.toString()));
        }
      }
    });
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
    on<ToggleAgreement>(_onToggleAgreement);
    on<InitializeFormState>(_onInitializeFormState);
  }
  void _onTogglePasswordVisibility(
    TogglePasswordVisibility event,
    Emitter<AuthState> emit,
  ) {
    state.maybeMap(
      formstate: (currentState) {
        emit(
          AuthState.formstate(
            !currentState.obscurePassword,
            currentState.isAgreed,
          ),
        );
      },
      orElse: () {
        // Initialize form state with toggled password visibility
        emit(AuthState.formstate(false, false)); // password visible, not agreed
      },
    );
  }

  void _onToggleAgreement(ToggleAgreement event, Emitter<AuthState> emit) {
    state.maybeMap(
      formstate: (currentState) {
        emit(
          AuthState.formstate(
            currentState.obscurePassword,
            !currentState.isAgreed,
          ),
        );
      },
      orElse: () {
        // Initialize form state with agreement checked
        emit(AuthState.formstate(true, true)); // password obscured, agreed
      },
    );
  }

  void _onInitializeFormState(
    InitializeFormState event,
    Emitter<AuthState> emit,
  ) {
    // Initialize form state with default values: password obscured, not agreed
    emit(AuthState.formstate(true, false));
  }
}

class ForgotPasswordBloc extends Bloc<AuthEvent, ForgotPasswordState> {
  final ForgotPasswordUser forgotPassword;
  ForgotPasswordBloc({required this.forgotPassword})
    : super(ForgotPasswordState.loading()) {
    on<ForgotPassword>(_onForgotPassword);
  }
  Future<void> _onForgotPassword(
    ForgotPassword event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(ForgotPasswordState.loading());
    try {
      // Call the use case here and await the result
      final resetToken = await forgotPassword.execute(event.email);
      emit(
        ForgotPasswordState.success(resetToken),
      ); // or ForgotPasswordSuccess(user: user) if you have a separate state
    } catch (e) {
      emit(ForgotPasswordState.failure(e.toString()));
    }
  }
}

class ResetPasswordBloc extends Bloc<AuthEvent, ResetPasswordState> {
  final ResetUserPassword resetpassword;
  ResetPasswordBloc({required this.resetpassword})
    : super(ResetPasswordState.loading()) {
    on<ResetPasswordRequested>(_onResetPassword);
  }
  Future<void> _onResetPassword(
    ResetPasswordRequested event,
    Emitter<ResetPasswordState> emit,
  ) async {
    emit(ResetPasswordState.loading());
    try {
      // Await the reset password execution
      final result = await resetpassword.execute(event.token, event.password);

      // Emit success with a message or the returned User
      emit(ResetPasswordState.success("Password successfully reset!,$result"));
    } catch (e) {
      emit(ResetPasswordState.failure(e.toString()));
    }
  }
}
