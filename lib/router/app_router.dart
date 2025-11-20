import 'package:auto_route/auto_route.dart';
import 'package:sangam/router/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: RegisterRoute.page),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: HomeLandingRoute.page),
    AutoRoute(page: ForgotPasswordRoute.page),
    AutoRoute(page: ResetPasswordRoute.page),
  ];
}
