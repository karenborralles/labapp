import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/usage_model.dart';
import '../../domain/entities/usage.dart';

class UsageRemoteDataSource {
  final String _baseUrl = 'http://192.168.1.79:3000/api/usages';

  Future<List<Usage>> fetchUsages() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      return body.map((json) => UsageModel.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar el historial de usos');
    }
  }
  
  Future<void> addUsage(Usage usage) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'productId'   : usage.productId,
        'quantityUsed': usage.quantityUsed,
        'recipient'   : usage.recipient,
        'usageDate'   : usage.usageDate.toIso8601String(),
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Error al registrar el uso');
    }
  }
}