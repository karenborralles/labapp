abstract class AuthRepository {
  Future<String?> login(String email, String password);
  Future<bool> register(String fullName, String email, String password);
}

class Login {
  final AuthRepository repository;

  Login(this.repository);

  Future<String?> call(String email, String password) {
    return repository.login(email, password);
  }
}