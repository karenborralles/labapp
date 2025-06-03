import '../../../domain/entities/product.dart';

abstract class ProductEvent {}

class LoadProductsEvent extends ProductEvent {}

class AddProductEvent extends ProductEvent {
  final Product product;

  AddProductEvent(this.product);
}

class DeleteProductEvent extends ProductEvent { 
  final int id;

  DeleteProductEvent(this.id);
}