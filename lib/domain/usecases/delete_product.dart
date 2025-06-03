import '../../data/repositories_impl/product_repository_impl.dart';

class DeleteProduct {
  final ProductRepositoryImpl repository;

  DeleteProduct(this.repository);

  Future<void> call(int id) async {
    return await repository.deleteProduct(id);
  }
}