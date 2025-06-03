import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  Future<String?> login(String email, String password) {
    return remoteDataSource.login(email, password);
  }

  Future<bool> register(String fullName, String email, String password) {
    return remoteDataSource.register(fullName, email, password);
  }
}