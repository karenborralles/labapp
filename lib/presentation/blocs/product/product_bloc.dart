import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_products.dart';
import '../../blocs/product/product_event.dart';
import '../../blocs/product/product_state.dart';
import '../../../domain/usecases/delete_product.dart'; 

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts getProducts;
  final DeleteProduct deleteProduct; 

  ProductBloc({
    required this.getProducts,
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