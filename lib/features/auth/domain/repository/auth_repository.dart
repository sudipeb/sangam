import 'package:sangam/features/auth/domain/entitiy/user.dart';

///responsible for handling user login and registration
/// actions and returning a [User] entity upon success
abstract class AuthRepository {
  Future<User> login(String email, String password);

  /// Registers a new user with the given [name], [email], and [password].
  Future<User> register(String name, String email, String password);
}
