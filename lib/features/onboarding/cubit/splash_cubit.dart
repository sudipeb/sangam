import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangam/features/onboarding/cubit/splash_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  Future<void> startSplash() async {
    await Future.delayed(Duration(seconds: 2));

    final prefs = await SharedPreferences.getInstance();
    final isFirstLaunch = prefs.getBool("first_launch") ?? true;
    final isLoggedIn = prefs.getBool("is_logged_in") ?? false;

    if (isFirstLaunch) {
      await prefs.setBool("first_launch", false);
      emit(SplashNavigateToRegistration());
    } else if (isLoggedIn) {
      emit(SplashNavigateToHome());
    } else {
      emit(SplashNavigateToRegistration());
    }
    debugPrint("isFirstTIME:$isFirstLaunch");
    debugPrint("isLoggedIn:$isLoggedIn");
  }
}
