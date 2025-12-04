import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sangam/core/constants/app_constants.dart';
import 'package:sangam/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:sangam/features/auth/presentation/bloc/auth_event.dart';
import 'package:sangam/features/auth/presentation/bloc/auth_state.dart';
import 'package:sangam/features/auth/presentation/widgets/auth_neuwromorphic_wrapper.dart';
import 'package:sangam/router/app_router.gr.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize form state when page loads
    context.read<AuthBloc>().add(InitializeFormState());
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) async {
            await state.maybeWhen(
              loginSuccess: (user) async {
                final scaffoldMessenger = ScaffoldMessenger.of(context);
                final router = AutoRouter.of(context);

                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool("is_logged_in", true);

                scaffoldMessenger.showSnackBar(
                  SnackBar(content: Text("Welcome ${user.name}!")),
                );

                router.replace(HomeLandingRoute());
              },
              failure: (message) async {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(message)));
              },
              orElse: () async {},
            );
          },
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 50.h),
                      Image.asset(ImageConstant.loginImage),
                      const SizedBox(height: 20),
                      Text(
                        "Log in to your account",
                        style: Theme.of(context).textTheme.headlineLarge
                            ?.copyWith(color: Colors.blueAccent),
                      ),
                      SizedBox(height: 50.h),
                      // Email Field
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Email",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 8),
                          softField(
                            child: TextFormField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                hintText: "Enter your Email Address",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Password Field
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Password",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 8),
                          BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              return state.maybeWhen(
                                formstate: (obscurePassword, isAgreed) {
                                  return softField(
                                    child: TextFormField(
                                      controller: _passwordController,
                                      obscureText: obscurePassword,
                                      decoration: InputDecoration(
                                        hintText: "Enter Password",
                                        border: const OutlineInputBorder(),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            obscurePassword
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                          ),
                                          onPressed: () => context
                                              .read<AuthBloc>()
                                              .add(TogglePasswordVisibility()),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                orElse: () {
                                  return softField(
                                    child: TextFormField(
                                      controller: _passwordController,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        hintText: "Enter Password",
                                        border: const OutlineInputBorder(),
                                        suffixIcon: IconButton(
                                          icon: const Icon(
                                            Icons.visibility_off,
                                          ),
                                          onPressed: () => context
                                              .read<AuthBloc>()
                                              .add(TogglePasswordVisibility()),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Remember Me + Forgot Password
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              BlocBuilder<AuthBloc, AuthState>(
                                builder: (context, state) {
                                  return state.maybeWhen(
                                    formstate: (obscurePassword, isAgreed) {
                                      return IconButton(
                                        onPressed: () => context
                                            .read<AuthBloc>()
                                            .add(ToggleAgreement()),
                                        icon: Icon(
                                          isAgreed
                                              ? Icons.check_circle
                                              : Icons.radio_button_off,
                                        ),
                                      );
                                    },
                                    orElse: () {
                                      return IconButton(
                                        onPressed: () => context
                                            .read<AuthBloc>()
                                            .add(ToggleAgreement()),
                                        icon: const Icon(
                                          Icons.radio_button_off,
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                              const Text("Remember Me?"),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              context.router.push(ForgotPasswordRoute());
                            },
                            child: Text(
                              "Forgot Password?",
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: const Color.fromARGB(
                                      255,
                                      233,
                                      64,
                                      3,
                                    ),
                                  ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Login Button
                      SizedBox(
                        height: 50.h,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blueGrey,
                            shadowColor: Colors.grey,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            final email = _emailController.text.trim();
                            final password = _passwordController.text.trim();
                            if (email.isEmpty || password.isEmpty) return;

                            context.read<AuthBloc>().add(
                              LoginRequested(email, password),
                            );
                          },
                          child: const Text("Login"),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Register Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?"),
                          TextButton(
                            onPressed: () =>
                                context.router.push(RegisterRoute()),
                            child: const Text("Create Account"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Loading Overlay
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    loading: () => SizedBox.expand(
                      child: Container(
                        color: Colors.black38,
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                    ),
                    orElse: () => const SizedBox.shrink(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
