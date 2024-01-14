import 'dart:convert';
import 'package:http/http.dart' as http;
import 'UserModelRequest.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  Future<UsermodelRequest> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      return UsermodelRequest.fromJson(json.decode(response.body));
    } else {
      throw Exception('Gagal login');
    }
  }

  Future<void> logout(String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/logout'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal logout');
    }
  }
}
