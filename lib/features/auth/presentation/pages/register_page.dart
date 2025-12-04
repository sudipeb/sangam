import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sangam/core/constants/app_constants.dart';
import 'package:sangam/core/utils/app_regex.dart';
import 'package:sangam/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:sangam/features/auth/presentation/bloc/auth_event.dart';
import 'package:sangam/features/auth/presentation/bloc/auth_state.dart';
import 'package:sangam/features/auth/presentation/widgets/auth_neuwromorphic_wrapper.dart';
import 'package:sangam/router/app_router.gr.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //  Add form key
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(InitializeFormState());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          state.maybeWhen(
            registerSuccess: (user) async {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Registration successful. Please login.'),
                ),
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
        builder: (context, state) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Form(
                      key: _formKey, //  Wrap in Form
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 40.h),
                          Image.asset(ImageConstant.userRegistration),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [Text("Full Name")],
                          ),
                          softField(
                            child: TextFormField(
                              controller: _nameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Full Name cannot be empty";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                hintText: "Enter Your Full Name",
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),

                          /// EMAIL
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [Text("Email")],
                          ),
                          softField(
                            child: TextFormField(
                              controller: _emailController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Email cannot be empty";
                                } else if (!AppRegex.emailRegex.hasMatch(
                                  value,
                                )) {
                                  return "Enter a valid email";
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                hintText: "Enter Email",
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),

                          /// PASSWORD
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [Text("Password")],
                          ),
                          BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, innerState) {
                              return innerState.maybeWhen(
                                formstate: (obscurePassword, isAgreed) {
                                  return softField(
                                    child: TextFormField(
                                      controller: _passwordController,
                                      obscureText: obscurePassword,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "Password cannot be empty";
                                        } else if (!AppRegex.passwordRegex
                                            .hasMatch(value)) {
                                          return "Password must be 8+ chars, include upper, lower, number & special char";
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        hintText: "Enter Password",
                                        border: InputBorder.none,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 14,
                                            ),
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
                                        border: InputBorder.none,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                              horizontal: 16,
                                              vertical: 14,
                                            ),
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

                          const SizedBox(height: 20),

                          /// TERMS & CONDITIONS
                          SizedBox(
                            height: 37.h,
                            width: 400.w,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BlocBuilder<AuthBloc, AuthState>(
                                  builder: (context, innerState) {
                                    return innerState.maybeWhen(
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
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
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
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                        );
                                      },
                                    );
                                  },
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
                                          style: const TextStyle(
                                            color: Colors.blue,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () async {
                                              final Uri url = Uri.parse(
                                                "https://example.com/user-agreement",
                                              );
                                              await launchUrl(
                                                url,
                                                mode: LaunchMode
                                                    .externalApplication,
                                              );
                                            },
                                        ),
                                        const TextSpan(text: " and agreed "),
                                        TextSpan(
                                          text: "Privacy Policy",
                                          style: const TextStyle(
                                            color: Colors.blue,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () async {
                                              final Uri url = Uri.parse(
                                                "https://example.com/privacy-policy",
                                              );
                                              await launchUrl(
                                                url,
                                                mode: LaunchMode
                                                    .externalApplication,
                                              );
                                            },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 20.h),

                          /// SUBMIT BUTTON
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.blueGrey,
                              shadowColor: Colors.grey,
                              elevation: 5,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final currentState = context
                                    .read<AuthBloc>()
                                    .state;
                                final isAgreed = currentState.maybeWhen(
                                  formstate: (obscurePassword, isAgreed) =>
                                      isAgreed,
                                  orElse: () => false,
                                );

                                if (!isAgreed) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Please agree to the terms and privacy policy',
                                      ),
                                    ),
                                  );
                                  return;
                                }

                                final name = _nameController.text.trim();
                                final email = _emailController.text.trim();
                                final password = _passwordController.text
                                    .trim();

                                context.read<AuthBloc>().add(
                                  RegisterRequested(name, email, password),
                                );
                              }
                            },
                            child: const Text("Sign Up"),
                          ),

                          SizedBox(height: 20.h),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Already have an account?"),
                              TextButton(
                                onPressed: () =>
                                    context.router.push(LoginRoute()),
                                child: const Text("Back to Login"),
                              ),
                            ],
                          ),
                          SizedBox(height: 40.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Loading overlay
              state.maybeWhen(
                loading: () => SizedBox.expand(
                  child: Container(
                    color: Colors.black38,
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                ),
                orElse: () => const SizedBox.shrink(),
              ),
            ],
          );
        },
      ),
    );
  }
}
