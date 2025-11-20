import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sangam/core/constants/api_constants.dart';
import 'package:sangam/core/network/api_client.dart';
import 'package:sangam/features/auth/data/models/user_model.dart';
import 'package:sangam/features/auth/domain/entity/user.dart';

class AuthRemoteDataSource {
  /// Instance of [ApiClient] to make network requests
  final ApiClient apiClient = ApiClient();

  /// Secure storage to save access and refresh tokens
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  /// Login: returns User after saving tokens
  Future<User> login(String email, String password) async {
    //  Login and get tokens
    final response = await apiClient.post(
      ApiEndpoints.login,
      data: {"email": email, "password": password},
    );

    final accessToken = response.data['accessToken'];
    final refreshToken = response.data['refreshToken'];

    if (accessToken == null || refreshToken == null) {
      throw Exception("Login failed: Tokens missing");
    }

    //Save tokens securely
    await _storage.write(key: 'accesstoken', value: accessToken);
    await _storage.write(key: 'refreshtoken', value: refreshToken);

    debugPrint("Tokens saved successfully!");

    //Fetch the logged-in user
    final userResponse = await apiClient.get("api/v1/auth/profile");

    if (userResponse.data['user'] == null) {
      throw Exception("User data missing after login");
    }

    //Return the User object
    return UserModel.fromJson(userResponse.data['user']);
  }

  ///Returns a [User] object if successfully registered
  Future<User> register(String name, String email, String password) async {
    final response = await apiClient.post(
      ApiEndpoints.register,
      data: {"name": name, "email": email, "password": password},
    );

    if (response.data['user'] == null) {
      throw Exception("User field missing in response");
    }

    return UserModel.fromJson(response.data['user']);
  }

  Future<String> forgotpassword(String email) async {
    final response = await apiClient.post(
      ApiEndpoints.forgotPassword,
      data: {"email": email},
    );

    final resetLink = response.data['resetPasswordLink'];
    if (resetLink == null) {
      throw Exception("Failed to get reset link");
    }

    // Extract token from the URL
    final uri = Uri.parse(resetLink);
    final token = uri.queryParameters['token'];
    if (token == null) {
      throw Exception("Reset token missing in response");
    }

    debugPrint("Reset token: $token");
    return token;
  }

  Future<bool> resetpassword({
    required String token,
    required String newPassword,
  }) async {
    final response = await apiClient.post(
      "${ApiEndpoints.resetPassword}?token=$token",
      data: {"token": token, "newPassword": newPassword},
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to reset password");
    }

    debugPrint("Password reset successful");
    return true;
  }
}
