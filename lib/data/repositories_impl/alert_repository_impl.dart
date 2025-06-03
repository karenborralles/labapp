import '../../domain/entities/product.dart';
import '../datasources/alert_remote_datasource.dart';

class AlertRepositoryImpl {
  final AlertRemoteDataSource remoteDataSource;

  AlertRepositoryImpl(this.remoteDataSource);

  Future<List<Product>> getAlerts() {
    return remoteDataSource.fetchAlerts();
  }
}