import 'package:shared_preferences/shared_preferences.dart';

class Token {
  static const String _userKey = 'token';
    static const String _user = 'useractive';

  Future<void> SetToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_userKey, token);
  } //

  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userKey);
  }

  Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_userKey);
  }

  Future<void> Logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_userKey);
  }

   Future<void> SetUser(String user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_user, user);
  }

   Future<String?> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_user);
  }
  
}
