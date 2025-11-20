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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ResetPasswordLoading) {
          // Optional: show loader
        }

        if (state is ResetPasswordSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));

          // Navigate to login screen
          context.router.replace(LoginRoute());
        }

        if (state is ResetPasswordFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        }
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
                  decoration: InputDecoration(
                    hintText: "Enter New Password",
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final newPassword = _passwordController.text.trim();

                    if (newPassword.isEmpty) return;
                    print("Pressed reset button. Password = $newPassword");
                    debugPrint("Reset token: $token");
                    context.read<AuthBloc>().add(
                      ResetPasswordRequested(
                        token: token,
                        password: newPassword,
                      ),
                    );
                  },
                  child: Text("Change Password"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
