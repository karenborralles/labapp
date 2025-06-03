abstract class AuthRepository {
  Future<String?> login(String email, String password);
  Future<bool> register(String fullName, String email, String password);
}