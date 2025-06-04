import '../../data/repositories_impl/product_repository_impl.dart';

class UpdateProductQuantity {
  final ProductRepositoryImpl repository;

  UpdateProductQuantity(this.repository);

  Future<void> call(int id, int newQuantity) async {
    return await repository.updateProductQuantity(id, newQuantity);
  }
}