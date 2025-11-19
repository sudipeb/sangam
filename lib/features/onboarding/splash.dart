import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sangam/core/constants/app_constants.dart';

@RoutePage()
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            SizedBox(
              height: 140.h,
              width: 140.w,
              child: Image.asset(
                ImageConstant.splashImage,
                fit: BoxFit.contain,
              ),
            ),

            SizedBox(height: 24.h),

            Text(
              "Sangam",
              style: TextStyle(
                fontSize: 36.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
                color: Colors.black87,
              ),
            ),

            SizedBox(height: 8.h),

            Text(
              "Connect. Share. Celebrate.",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 56, 5, 182),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
