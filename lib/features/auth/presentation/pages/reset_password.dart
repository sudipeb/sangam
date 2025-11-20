import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sangam/features/auth/presentation/widgets/auth_neuwromorphic_wrapper.dart';

@RoutePage()
class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Enter Your Email Address to reset password."),
          softField(
            child: TextFormField(
              // controller: _emailController,
              decoration: const InputDecoration(
                hintText: "Enter your Email Address",
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
