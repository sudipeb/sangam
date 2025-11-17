import 'package:sangam/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:sangam/features/auth/domain/entity/user.dart';
import 'package:sangam/features/auth/domain/repository/auth_repository.dart';

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
}
