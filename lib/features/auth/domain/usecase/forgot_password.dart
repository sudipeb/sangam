import 'package:sangam/features/auth/domain/entity/user.dart';
import 'package:sangam/features/auth/domain/repository/auth_repository.dart';

///Encapsulates the Login logic by delegating the actual
///operation to the [AuthRepository].
class ForgotPasswordUser {
  final AuthRepository repository;
  ForgotPasswordUser(this.repository);

  Future<User> execute(String email) {
    return repository.forgotpassword(email);
  }
}
