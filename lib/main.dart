import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:sangam/core/theme/theme.dart';
import 'package:sangam/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:sangam/features/auth/data/repository/auth_repo_impl.dart';
import 'package:sangam/features/auth/domain/usecase/forgot_password.dart';
import 'package:sangam/features/auth/domain/usecase/login_user.dart';
import 'package:sangam/features/auth/domain/usecase/register_user.dart';
import 'package:sangam/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:sangam/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('authBox');
  final authRepository = AuthRepositoryImpl(
    remoteDataSource: AuthRemoteDataSource(),
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            loginUser: LoginUser(authRepository),
            registerUser: RegisterUser(authRepository),
            forgotPassword: ForgotPasswordUser(authRepository),
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(440, 956),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp.router(
          routerConfig: _appRouter.config(),
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
        );
      },
    );
  }
}
