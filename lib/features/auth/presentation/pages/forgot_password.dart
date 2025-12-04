import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sangam/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:sangam/features/auth/presentation/bloc/auth_event.dart';
import 'package:sangam/features/auth/presentation/bloc/auth_state.dart';
import 'package:sangam/features/auth/presentation/widgets/auth_neuwromorphic_wrapper.dart';
import 'package:sangam/router/app_router.gr.dart';

@RoutePage()
class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
        listener: (context, state) {
          state.maybeWhen(
            success: (resetPasswordToken) {
              context.router.push(
                ResetPasswordRoute(token: resetPasswordToken),
              );

              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("Reset link sent!")));
            },
            failure: (error) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(error)));
            },
            loading: () {
              // Optional: show a loading overlay
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) =>
                    const Center(child: CircularProgressIndicator()),
              );
            },
            orElse: () {
              // Close the loading overlay if any
              if (Navigator.canPop(context)) Navigator.pop(context);
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text("Enter your email address to reset password."),
                ],
              ),
              const SizedBox(height: 10),
              softField(
                child: TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: "Enter your Email Address",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final email = _emailController.text.trim();
                    if (email.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please enter a valid email"),
                        ),
                      );
                      return;
                    }

                    ///TODO:fIX THIS DIRTY STATE ERROR
                    context.read<ForgotPasswordBloc>().add(
                      ForgotPassword(email),
                    );
                  },
                  child: const Text("Send Password Change Link"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
