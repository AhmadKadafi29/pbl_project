import 'sharedPreferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pbl_project/PersonalModel.dart';

class ProfileApi{
  Token token = Token();
  String endpoint = 'http://10.0.2.2:8000/api/profile';

  Future<List<Personal>> fetchData() async {
    final response = await http.get(
      Uri.parse(endpoint),
      headers: <String, String>{
        'Authorization': 'Bearer ${await token.getToken()}'
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = json.decode(response.body);
      Map<String, dynamic> userData = responseBody['user'];
      Personal user = Personal.fromJson(userData);
      return [user];
    } else {
      throw "Failed to load data";
    }
  }

}