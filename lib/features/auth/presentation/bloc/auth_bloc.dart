import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangam/core/network/network_exceptions.dart';
import 'package:sangam/features/auth/domain/usecase/login_user.dart';
import 'package:sangam/features/auth/domain/usecase/register_user.dart';
import 'package:sangam/features/auth/presentation/bloc/auth_event.dart';
import 'package:sangam/features/auth/presentation/bloc/auth_state.dart';

///[Bloc] to handle authentication logic
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUser loginUser;
  final RegisterUser registerUser;
  AuthBloc({required this.loginUser, required this.registerUser})
    : super(AuthInitial()) {
    // Handler for LoginRequested event
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await loginUser.execute(event.email, event.password);
        emit(AuthSuccess(user: user));
      } catch (e) {
        if (e is NetworkExceptions) {
          emit(AuthFailure(message: e.message));
        } else {
          emit(AuthFailure(message: e.toString()));
        }
      }
    });
    // Handler for RegisterRequested event
    on<RegisterRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await registerUser.execute(
          event.name,
          event.email,
          event.password,
        );
        emit(AuthSuccess(user: user));
      } catch (e) {
        if (e is NetworkExceptions) {
          emit(AuthFailure(message: e.message));
        } else {
          emit(AuthFailure(message: e.toString()));
        }
      }
    });
  }
}
