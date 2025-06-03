import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product_model.dart';
import '../../domain/entities/product.dart';

class AlertRemoteDataSource {
  final String _baseUrl = 'http://192.168.1.79:3000/api/alerts'; 

  Future<List<Product>> fetchAlerts() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      return body.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar las alertas');
    }
  }
}