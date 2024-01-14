import 'package:flutter/material.dart';
import 'package:pbl_project/home.dart';
import 'package:pbl_project/login_page.dart';
import 'sharedPreferences.dart';
import 'package:flutter/material.dart' show showDialog;


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Token token = Token();

  Future<bool> _loginCheck() async {
    try {
      bool isLoggedIn = await token.isLoggedIn();
      if (isLoggedIn) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print("Error during login: $error");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<bool>(
        future: _loginCheck(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == true) {
              return const Home();
            } else {
              return const LoginPage();
            }
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
