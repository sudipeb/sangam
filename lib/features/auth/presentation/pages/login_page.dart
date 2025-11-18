import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sangam/core/network/network_exceptions.dart';
import 'package:sangam/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:sangam/features/auth/data/repository/auth_repo_impl.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final authRepository = AuthRepositoryImpl(
    remoteDataSource: AuthRemoteDataSource(),
  );

  @override
  Widget build(context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: "Username"),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: "Password"),
            ),
            ElevatedButton(
              onPressed: () async {
                final email = _usernameController.text.trim();
                final password = _passwordController.text.trim();
                if (email.isEmpty || password.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please fill all fields")),
                  );
                  return;
                }
                try {
                  final user = await authRepository.login(email, password);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Welcome ${user.name}!")),
                  );
                } catch (e) {
                  if (e is NetworkExceptions) {
                    print("Login Failed:$e");
                  }
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   SnackBar(content: Text("Login failed: ${e.toString()}")),
                  // );
                }
              },
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
