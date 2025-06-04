import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:labapp/presentation/blocs/alert/alert_bloc.dart';
import 'package:labapp/presentation/blocs/alert/alert_event.dart';
import '../../../domain/usecases/get_products.dart';
import '../../../domain/usecases/add_product.dart';   
import '../../../domain/usecases/delete_product.dart'; 
import '../../../domain/usecases/update_product_quantity.dart'; 
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts getProducts;
  final AddProduct addProduct;        
  final DeleteProduct deleteProduct;
  final UpdateProductQuantity updateProductQuantity; 
  final AlertBloc alertBloc;

  ProductBloc({
    required this.getProducts,
    required this.addProduct,        
    required this.deleteProduct,
    required this.updateProductQuantity, 
    required this.alertBloc,
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
        alertBloc.add(LoadAlertsEvent());
      } catch (e) {
        emit(ProductError('Error al agregar producto'));
      }
    });

    on<DeleteProductEvent>((event, emit) async {
      try {
        await deleteProduct(event.id);
        add(LoadProductsEvent()); 
        alertBloc.add(LoadAlertsEvent());
      } catch (e) {
        emit(ProductError('Error al eliminar producto'));
      }
    });

    on<UpdateProductQuantityEvent>((event, emit) async {
      try {
        await updateProductQuantity(event.id, event.newQuantity);
        add(LoadProductsEvent()); 
        alertBloc.add(LoadAlertsEvent()); 
      } catch (e) {
        emit(ProductError('Error al actualizar cantidad'));
      }
    });

    on<UpdateProductEvent>((event, emit) async {
      try {
        await updateProductQuantity(event.id, event.newQuantity);
        add(LoadProductsEvent());
      } catch (e) {
        emit(ProductError('Error al actualizar cantidad'));
      }
    });
  }
}