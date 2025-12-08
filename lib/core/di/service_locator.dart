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

// Social feed imports
import 'package:sangam/features/socialfeed/data/datasource/post_remote_datasource.dart';
import 'package:sangam/features/socialfeed/data/repositories/post_repository_impl.dart';
import 'package:sangam/features/socialfeed/domain/repositories/post_repository.dart';
import 'package:sangam/features/socialfeed/domain/usecases/create_post_usecase.dart';
import 'package:sangam/features/socialfeed/domain/usecases/fetch_feeds_usecase.dart';
import 'package:sangam/features/socialfeed/presentation/blocs/create_post_bloc.dart';
import 'package:sangam/features/socialfeed/presentation/blocs/feeds_bloc.dart';

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
  // Social feed datasource
  getIt.registerLazySingleton<PostRemoteDataSource>(
    () => PostRemoteDataSource(),
  );

  // Social feed repository
  getIt.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(getIt<PostRemoteDataSource>()),
  );

  // Social feed use cases
  getIt.registerLazySingleton<CreatePostUseCase>(
    () => CreatePostUseCase(getIt<PostRepository>()),
  );

  getIt.registerLazySingleton<FetchFeedsUseCase>(
    () => FetchFeedsUseCase(getIt<PostRepository>()),
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

  // Social feed blocs
  getIt.registerFactory<CreatePostBloc>(
    () => CreatePostBloc(getIt<CreatePostUseCase>()),
  );

  getIt.registerFactory<FeedsBloc>(() => FeedsBloc(getIt<FetchFeedsUseCase>()));
}
