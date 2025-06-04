import '../../domain/entities/product.dart';
import '../datasources/product_remote_datasource.dart';

class ProductRepositoryImpl {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  Future<List<Product>> getProducts() async {
    return await remoteDataSource.getProducts();
  }

  Future<void> deleteProduct(int id) async {
    await remoteDataSource.deleteProduct(id);
  }

  Future<void> addProduct(Product product) async {
    await remoteDataSource.addProduct(product);
  }

  Future<void> updateProductQuantity(int id, int newQuantity) async {
    await remoteDataSource.updateProductQuantity(id, newQuantity);
  }
}