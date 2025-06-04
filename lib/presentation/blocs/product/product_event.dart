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

class UpdateProductQuantityEvent extends ProductEvent {
  final int id;
  final int newQuantity;

  UpdateProductQuantityEvent(this.id, this.newQuantity);
}

class UpdateProductEvent extends ProductEvent {
  final int id;
  final int newQuantity;

  UpdateProductEvent(this.id, this.newQuantity);
}