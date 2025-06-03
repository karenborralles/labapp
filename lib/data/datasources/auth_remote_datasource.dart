import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthRemoteDataSource {
  final String baseUrl = "http://192.168.1.79:3000/api/auth"; 

  Future<String?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      return body['name'];
    } else {
      return null;
    }
  }

  Future<bool> register(String fullName, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "fullName": fullName,
        "email": email,
        "password": password,
      }),
    );

    return response.statusCode == 201;
  }
}