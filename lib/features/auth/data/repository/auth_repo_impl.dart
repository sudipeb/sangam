import 'package:sangam/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:sangam/features/auth/domain/entity/user.dart';
import 'package:sangam/features/auth/domain/repository/auth_repository.dart';

/// Implementation of [AuthRepository] which handles authentication operations.
/// Delegates the actual API calls to the [AuthRemoteDataSource].
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<User> login(String email, String password) {
    return remoteDataSource.login(email, password);
  }

  @override
  Future<User> register(String name, String email, String password) {
    return remoteDataSource.register(name, email, password);
  }

  /// Returns the reset token as a String
  @override
  Future<String> forgotpassword(String email) {
    return remoteDataSource.forgotpassword(email);
  }

  /// Returns true if password reset is successful
  @override
  Future<bool> resetpassword(String token, String newPassword) {
    return remoteDataSource.resetpassword(
      token: token,
      newPassword: newPassword,
    );
  }
}
