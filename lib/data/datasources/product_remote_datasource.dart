import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../domain/entities/product.dart';

class ProductRemoteDataSource {
  final String baseUrl = 'http://192.168.1.79:3000/api/products';

  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar productos');
    }
  }

  Future<void> addProduct(Product product) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(product.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Error al agregar producto');
    }
  }

  Future<void> deleteProduct(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Error al eliminar producto');
    }
  }

  Future<void> updateProductQuantity(int id, int newQuantity) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'quantity': newQuantity}),
    );
    if (response.statusCode != 200) {
      throw Exception('Error al actualizar producto');
    }
  }
}