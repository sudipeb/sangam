// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:sangam/features/auth/presentation/pages/login_page.dart' as _i2;
import 'package:sangam/features/auth/presentation/pages/register_page.dart'
    as _i3;
import 'package:sangam/features/home/presentation/pages/home_landing_page.dart'
    as _i1;
import 'package:sangam/features/onboarding/splash.dart' as _i4;

/// generated route for
/// [_i1.HomeLandingPage]
class HomeLandingRoute extends _i5.PageRouteInfo<void> {
  const HomeLandingRoute({List<_i5.PageRouteInfo>? children})
    : super(HomeLandingRoute.name, initialChildren: children);

  static const String name = 'HomeLandingRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i1.HomeLandingPage();
    },
  );
}

/// generated route for
/// [_i2.LoginPage]
class LoginRoute extends _i5.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({_i6.Key? key, List<_i5.PageRouteInfo>? children})
    : super(
        LoginRoute.name,
        args: LoginRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'LoginRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<LoginRouteArgs>(
        orElse: () => const LoginRouteArgs(),
      );
      return _i2.LoginPage(key: args.key);
    },
  );
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key});

  final _i6.Key? key;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! LoginRouteArgs) return false;
    return key == other.key;
  }

  @override
  int get hashCode => key.hashCode;
}

/// generated route for
/// [_i3.RegisterPage]
class RegisterRoute extends _i5.PageRouteInfo<RegisterRouteArgs> {
  RegisterRoute({_i6.Key? key, List<_i5.PageRouteInfo>? children})
    : super(
        RegisterRoute.name,
        args: RegisterRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'RegisterRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RegisterRouteArgs>(
        orElse: () => const RegisterRouteArgs(),
      );
      return _i3.RegisterPage(key: args.key);
    },
  );
}

class RegisterRouteArgs {
  const RegisterRouteArgs({this.key});

  final _i6.Key? key;

  @override
  String toString() {
    return 'RegisterRouteArgs{key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! RegisterRouteArgs) return false;
    return key == other.key;
  }

  @override
  int get hashCode => key.hashCode;
}

/// generated route for
/// [_i4.SplashPage]
class SplashRoute extends _i5.PageRouteInfo<void> {
  const SplashRoute({List<_i5.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i4.SplashPage();
    },
  );
}
