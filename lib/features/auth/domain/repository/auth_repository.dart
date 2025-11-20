import 'package:sangam/features/auth/domain/entity/user.dart';

///responsible for handling user login and registration actions
///returnns a [User] entity upon success
abstract class AuthRepository {
  Future<User> login(String email, String password);

  /// Registers a new user with the given [name], [email], and [password].
  Future<User> register(String name, String email, String password);
  Future<User> forgotpassword(String email);
}
