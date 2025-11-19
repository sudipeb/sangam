import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangam/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:sangam/features/auth/presentation/bloc/auth_event.dart';
import 'package:sangam/features/auth/presentation/bloc/auth_state.dart';
import 'package:sangam/router/app_router.gr.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text("Logging in...")));
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

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: "Email"),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: "Password"),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
