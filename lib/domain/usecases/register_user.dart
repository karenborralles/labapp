// PON ESTO EN register_user.dart

// 👇 IMPORTA login.dart para traer AuthRepository
import 'login.dart';

class RegisterUser {
  final AuthRepository repository;

  RegisterUser(this.repository);

  Future<bool> call(String fullName, String email, String password) {
    return repository.register(fullName, email, password);
  }
}
