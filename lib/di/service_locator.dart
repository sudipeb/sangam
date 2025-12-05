import 'package:get_it/get_it.dart';
import 'package:sangam/core/network/api_client.dart';
import 'package:sangam/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:sangam/features/auth/data/repository/auth_repo_impl.dart';
import 'package:sangam/features/auth/domain/usecase/forgot_password.dart';
import 'package:sangam/features/auth/domain/usecase/login_user.dart';
import 'package:sangam/features/auth/domain/usecase/register_user.dart';
import 'package:sangam/features/auth/domain/usecase/reset_password.dart';

import 'package:sangam/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:sangam/core/services/rest_api_service.dart';

final GetIt getIt = GetIt.instance;

void setupDependencies() {
  // Core
  getIt.registerSingleton<ApiClient>(ApiClient());
  // REST wrapper service (singleton)
  getIt.registerLazySingleton<RestApiService>(() => RestApiService());

  // Data sources
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(),
  );

  // Repositories
  getIt.registerLazySingleton<AuthRepositoryImpl>(
    () => AuthRepositoryImpl(remoteDataSource: getIt<AuthRemoteDataSource>()),
  );

  // Usecases
  getIt.registerLazySingleton<LoginUser>(
    () => LoginUser(getIt<AuthRepositoryImpl>()),
  );
  getIt.registerLazySingleton<RegisterUser>(
    () => RegisterUser(getIt<AuthRepositoryImpl>()),
  );
  getIt.registerLazySingleton<ForgotPasswordUser>(
    () => ForgotPasswordUser(getIt<AuthRepositoryImpl>()),
  );
  getIt.registerLazySingleton<ResetUserPassword>(
    () => ResetUserPassword(getIt<AuthRepositoryImpl>()),
  );

  // Blocs
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(
      loginUser: getIt<LoginUser>(),
      registerUser: getIt<RegisterUser>(),
    ),
  );

  getIt.registerFactory<ForgotPasswordBloc>(
    () => ForgotPasswordBloc(forgotPassword: getIt<ForgotPasswordUser>()),
  );

  getIt.registerFactory<ResetPasswordBloc>(
    () => ResetPasswordBloc(resetpassword: getIt<ResetUserPassword>()),
  );
}
