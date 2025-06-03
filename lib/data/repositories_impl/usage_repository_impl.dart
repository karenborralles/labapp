import '../../domain/entities/usage.dart';
import '../datasources/usage_remote_datasource.dart';

class UsageRepositoryImpl {
  final UsageRemoteDataSource remoteDataSource;

  UsageRepositoryImpl(this.remoteDataSource);

  Future<List<Usage>> getUsages() {
    return remoteDataSource.fetchUsages();
  }

  Future<void> addUsage(Usage usage) {
    return remoteDataSource.addUsage(usage);
  }
}