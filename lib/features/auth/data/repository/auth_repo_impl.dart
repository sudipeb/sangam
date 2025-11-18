import 'package:sangam/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:sangam/features/auth/domain/entity/user.dart';
import 'package:sangam/features/auth/domain/repository/auth_repository.dart';

/// Implementation of [AuthRepository] which handles authentication operations.
/// delegates the actual API calls to the [AuthRemoteDataSource].
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  /// Delegates to [AuthRemoteDataSource.login] method
  @override
  Future<User> login(String email, String password) {
    return remoteDataSource.login(email, password);
  }

  /// Delegates to [AuthRemoteDataSource.register] method
  @override
  Future<User> register(String name, String email, String password) {
    return remoteDataSource.register(name, email, password);
  }
}
