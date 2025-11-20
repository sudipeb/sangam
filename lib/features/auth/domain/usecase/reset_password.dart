
import 'package:sangam/features/auth/domain/repository/auth_repository.dart';

///Encapsulates the Login logic by delegating the actual
///operation to the [AuthRepository].
class ResetUserPassword {
  final AuthRepository repository;
  ResetUserPassword(this.repository);

  Future<bool> execute(String token, String newPassword) {
    return repository.resetpassword(token, newPassword);
  }
}
