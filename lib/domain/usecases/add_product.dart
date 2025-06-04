import '../../data/repositories_impl/product_repository_impl.dart';
import '../entities/product.dart';

class AddProduct {
  final ProductRepositoryImpl repository;

  AddProduct(this.repository);

  Future<void> call(Product product) async {
    await repository.remoteDataSource.addProduct(product);
  }
}