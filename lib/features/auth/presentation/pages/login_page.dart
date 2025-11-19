import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sangam/core/constants/app_constants.dart';
import 'package:sangam/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:sangam/features/auth/presentation/bloc/auth_event.dart';
import 'package:sangam/features/auth/presentation/bloc/auth_state.dart';
import 'package:sangam/router/app_router.gr.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) async {
              if (state is AuthLoading) {
                CircularProgressIndicator();
              } else if (state is AuthSuccess) {
                // Capture navigator and messenger synchronously
                final scaffoldMessenger = ScaffoldMessenger.of(context);
                final router = AutoRouter.of(context);

                // Do async work
                SharedPreferences.getInstance().then((prefs) {
                  prefs.setBool("is_logged_in", true);

                  // Safe: using previously captured context-dependent objects
                  scaffoldMessenger.showSnackBar(
                    SnackBar(content: Text("Welcome ${state.user.name}!")),
                  );
                  router.replace(HomeLandingRoute());
                });
              } else if (state is AuthFailure) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },

            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(ImageConstant.loginImage),
                  Text(
                    "Log in to your account",
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Colors.blueAccent,
                    ),
                  ),
                  SizedBox(height: 50.h),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Email Address",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Password",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "Forgot Password?",
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: const Color.fromARGB(255, 233, 64, 3),
                              ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 37.h,
                    width: 400.w,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.radio_button_off),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 14,
                              ),
                              children: [
                                const TextSpan(text: "I've read "),
                                TextSpan(
                                  text: "User Agreement",
                                  style: const TextStyle(color: Colors.blue),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      final Uri url = Uri.parse(
                                        "https://example.com/user-agreement",
                                      );
                                      if (!await launchUrl(url)) {
                                        throw 'Could not launch $url';
                                      }
                                    },
                                ),
                                const TextSpan(text: " and agreed "),
                                TextSpan(
                                  text: "Privacy Policy",
                                  style: const TextStyle(color: Colors.blue),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      final Uri url = Uri.parse(
                                        "https://example.com/privacy-policy",
                                      );
                                      if (!await launchUrl(url)) {
                                        throw 'Could not launch $url';
                                      }
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    height: 50.h,
                    width: 200.w,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue, // Text / icon color
                        shadowColor: Colors.grey, // Shadow color
                        elevation: 5, // Shadow elevation
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        final email = _emailController.text.trim();
                        final password = _passwordController.text.trim();
                        if (email.isEmpty || password.isEmpty) return;
                        // Dispatch login via Bloc
                        context.read<AuthBloc>().add(
                          LoginRequested(email, password),
                        );
                      },
                      child: const Text("Login"),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?"),
                      TextButton(
                        onPressed: () => context.router.push(RegisterRoute()),
                        child: Text("Create Account"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
