import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangam/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:sangam/features/auth/presentation/bloc/auth_event.dart';
import 'package:sangam/features/auth/presentation/bloc/auth_state.dart';
import 'package:sangam/router/app_router.gr.dart';

@RoutePage()
class ResetPasswordPage extends StatelessWidget {
  final String token;
  final TextEditingController _passwordController = TextEditingController();

  ResetPasswordPage({required this.token, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordBloc, ResetPasswordState>(
      listener: (context, state) {
        // Note: Reset password uses a different bloc/state - this might need adjustment
        // For now, keeping the structure similar to other auth pages
        state.maybeWhen(
          success: (user) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Password reset successful!")),
            );
            context.router.replace(LoginRoute());
          },
          failure: (message) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(message)));
          },
          orElse: () {},
        );
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    hintText: "Enter New Password",
                    border: OutlineInputBorder(),
                  ),
                  obscureText: false,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final newPassword = _passwordController.text.trim();

                    if (newPassword.isEmpty) return;
                    debugPrint("Reset token: $token");
                    context.read<ResetPasswordBloc>().add(
                      ResetPasswordRequested(
                        token: token,
                        password: newPassword,
                      ),
                    );
                  },
                  child: const Text("Change Password"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
