import 'package:sangam/core/network/api_client.dart';
import 'package:sangam/features/auth/data/models/user_model.dart';

class AuthRemoteDataSource {
  final ApiClient apiClient = ApiClient();
  Future<UserModel> login(String email, String password) async {
    final response = await apiClient.post(
      "api/v1/auth/login",
      data: {"email": email, "password": password},
    );
    return UserModel.fromJson(response.data['users']);
  }

  Future<UserModel> register(String name, String email, String password) async {
    final response = await apiClient.post(
      "api/v1/auth/register",
      data: {"name": name, "email": email, "password": password},
    );
    return UserModel.fromJson(response.data['users']);
  }
}
