import 'package:http/http.dart' as http;
import 'sharedPreferences.dart';

class Logout {
  final Token _token = Token();
  final String _endpoint = 'http://10.0.2.2:8000/api/logout';

  Future<void> logoutUser() async {
    final response = await http.post(
      Uri.parse(_endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${await _token.getToken()}'
      },
    );

    if (response.statusCode == 201) {
    } else {
      throw "Failed to logout";
    }
  }
}
