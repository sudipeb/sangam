import 'package:sangam/features/auth/domain/entitiy/user.dart';
import 'package:sangam/features/auth/domain/repository/auth_repository.dart';

///Encapsulates the registration logic by delegating the actual
///operation to the [AuthRepository].
class RegisterUser {
  final AuthRepository repository;
  RegisterUser(this.repository);
  Future<User> execute(String name, String email, String password) {
    return repository.register(name, email, password);
  }
}
