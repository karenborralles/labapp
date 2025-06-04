import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_products.dart';
import '../../../domain/usecases/add_product.dart';   
import '../../../domain/usecases/delete_product.dart'; 
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts getProducts;
  final AddProduct addProduct;        
  final DeleteProduct deleteProduct; 

  ProductBloc({
    required this.getProducts,
    required this.addProduct,        
    required this.deleteProduct,
  }) : super(ProductInitial()) {
    
    on<LoadProductsEvent>((event, emit) async {
      emit(ProductLoading());
      try {
        final products = await getProducts();
        emit(ProductLoaded(products));
      } catch (e) {
        emit(ProductError('Error al cargar productos'));
      }
    });

    on<AddProductEvent>((event, emit) async {
      try {
        await addProduct(event.product);    
        add(LoadProductsEvent());           
      } catch (e) {
        emit(ProductError('Error al agregar producto'));
      }
    });

    on<DeleteProductEvent>((event, emit) async {
      try {
        await deleteProduct(event.id);
        add(LoadProductsEvent()); 
      } catch (e) {
        emit(ProductError('Error al eliminar producto'));
      }
    });
  }
}