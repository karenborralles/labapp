import '../../data/repositories_impl/product_repository_impl.dart';
import '../entities/product.dart';

class GetProducts {
  final ProductRepositoryImpl repository;

  GetProducts(this.repository);

  Future<List<Product>> call() async {
    return await repository.getProducts();
  }
}