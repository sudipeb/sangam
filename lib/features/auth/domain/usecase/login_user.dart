import 'package:sangam/features/auth/domain/entitiy/user.dart';
import 'package:sangam/features/auth/domain/repository/auth_repository.dart';

///Encapsulates the Login logic by delegating the actual
///operation to the [AuthRepository].
class LoginUser {
  final AuthRepository repository;
  LoginUser(this.repository);

  Future<User> execute(String email, String password) {
    return repository.login(email, password);
  }
}
