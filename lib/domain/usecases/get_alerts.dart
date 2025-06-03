import '../entities/product.dart';
import '../../data/repositories_impl/alert_repository_impl.dart';

class GetAlerts {
  final AlertRepositoryImpl repository;

  GetAlerts(this.repository);

  Future<List<Product>> call() async {
    return await repository.getAlerts();
  }
}