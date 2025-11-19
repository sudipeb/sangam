import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sangam/features/onboarding/cubit/splash_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  Future<void> startSplash() async {
    final storage = FlutterSecureStorage();
    await Future.delayed(Duration(seconds: 2));

    final prefs = await SharedPreferences.getInstance();
    final isFirstLaunch = prefs.getBool("first_launch") ?? true;

    if (isFirstLaunch) {
      prefs.setBool("first_launch", false);
      emit(SplashNavigateToRegistration());
      return;
    }

    final token = await storage.read(key: "access_token");

    if (token != null) {
      emit(SplashNavigateToHome());
    } else {
      emit(SplashNavigateToRegistration());
    }
  }
}
