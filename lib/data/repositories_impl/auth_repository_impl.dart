import '../../domain/usecases/login.dart';  
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<String?> login(String email, String password) {
    return remoteDataSource.login(email, password);
  }

  @override
  Future<bool> register(String fullName, String email, String password) {
    return remoteDataSource.register(fullName, email, password);
  }
}