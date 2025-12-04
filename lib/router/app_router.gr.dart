// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;
import 'package:sangam/features/auth/presentation/pages/forgot_password.dart'
    as _i1;
import 'package:sangam/features/auth/presentation/pages/login_page.dart' as _i3;
import 'package:sangam/features/auth/presentation/pages/register_page.dart'
    as _i4;
import 'package:sangam/features/auth/presentation/pages/reset_password.dart'
    as _i5;
import 'package:sangam/features/home/presentation/pages/home_landing_page.dart'
    as _i2;
import 'package:sangam/features/onboarding/splash.dart' as _i6;

/// generated route for
/// [_i1.ForgotPasswordPage]
class ForgotPasswordRoute extends _i7.PageRouteInfo<ForgotPasswordRouteArgs> {
  ForgotPasswordRoute({_i8.Key? key, List<_i7.PageRouteInfo>? children})
    : super(
        ForgotPasswordRoute.name,
        args: ForgotPasswordRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'ForgotPasswordRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ForgotPasswordRouteArgs>(
        orElse: () => const ForgotPasswordRouteArgs(),
      );
      return _i1.ForgotPasswordPage(key: args.key);
    },
  );
}

class ForgotPasswordRouteArgs {
  const ForgotPasswordRouteArgs({this.key});

  final _i8.Key? key;

  @override
  String toString() {
    return 'ForgotPasswordRouteArgs{key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ForgotPasswordRouteArgs) return false;
    return key == other.key;
  }

  @override
  int get hashCode => key.hashCode;
}

/// generated route for
/// [_i2.HomeLandingPage]
class HomeLandingRoute extends _i7.PageRouteInfo<void> {
  const HomeLandingRoute({List<_i7.PageRouteInfo>? children})
    : super(HomeLandingRoute.name, initialChildren: children);

  static const String name = 'HomeLandingRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomeLandingPage();
    },
  );
}

/// generated route for
/// [_i3.LoginPage]
class LoginRoute extends _i7.PageRouteInfo<void> {
  const LoginRoute({List<_i7.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i3.LoginPage();
    },
  );
}

/// generated route for
/// [_i4.RegisterPage]
class RegisterRoute extends _i7.PageRouteInfo<void> {
  const RegisterRoute({List<_i7.PageRouteInfo>? children})
    : super(RegisterRoute.name, initialChildren: children);

  static const String name = 'RegisterRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i4.RegisterPage();
    },
  );
}

/// generated route for
/// [_i5.ResetPasswordPage]
class ResetPasswordRoute extends _i7.PageRouteInfo<ResetPasswordRouteArgs> {
  ResetPasswordRoute({
    required String token,
    _i8.Key? key,
    List<_i7.PageRouteInfo>? children,
  }) : super(
         ResetPasswordRoute.name,
         args: ResetPasswordRouteArgs(token: token, key: key),
         initialChildren: children,
       );

  static const String name = 'ResetPasswordRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ResetPasswordRouteArgs>();
      return _i5.ResetPasswordPage(token: args.token, key: args.key);
    },
  );
}

class ResetPasswordRouteArgs {
  const ResetPasswordRouteArgs({required this.token, this.key});

  final String token;

  final _i8.Key? key;

  @override
  String toString() {
    return 'ResetPasswordRouteArgs{token: $token, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ResetPasswordRouteArgs) return false;
    return token == other.token && key == other.key;
  }

  @override
  int get hashCode => token.hashCode ^ key.hashCode;
}

/// generated route for
/// [_i6.SplashPage]
class SplashRoute extends _i7.PageRouteInfo<void> {
  const SplashRoute({List<_i7.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i6.SplashPage();
    },
  );
}
