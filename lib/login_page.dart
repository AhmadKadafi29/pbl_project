import 'package:flutter/material.dart';
import 'UserModel/UserModelRequest.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'sharedPreferences.dart';
import 'home.dart';
import 'PersonalModel.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final _EmailController = TextEditingController();
  final _PasswordController = TextEditingController();
  String username = '';
  Token token = Token();

  void _SubmitData() async {
    final enteredEmail = _EmailController.text;
    final enteredPassword = _PasswordController.text;

    if (enteredEmail.isEmpty || enteredPassword.isEmpty) {
      return;
    }

    final UsermodelRequest User =
        UsermodelRequest(email: enteredEmail, password: enteredPassword);

    bool loginSuccess = await _Login(User);

    if (loginSuccess) {
      List<Personal> listuser = await getactiveuser();
      String FullName = listuser[0].nama;

      setState(() {
        username = FullName;
      });

      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Home(username: username),
        ),
      );
    } else {
      // ignore: use_build_context_synchronously
       showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Login Gagal"),
          content: const Text("Username atau password salah."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  Future<List<Personal>> getactiveuser() async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/profile'),
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

  Future<bool> _Login(UsermodelRequest Users) async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/login'),
        headers: <String, String>{
          'content-type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(Users.toJson()),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> tokens = jsonDecode(response.body);
        String token = tokens['token'];
        Token save = new Token();
        save.SetToken(token);
        return true; // Berhasil login
      } else {
        // Gagal login, kembalikan false
        return false;
      }
    } catch (error) {
      // Tangani kesalahan pada saat login
      print("Error during login: $error");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 80,
              ),
              Center(
                child: Image.asset(
                  'assets/logo.png',
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              const Text(
                "Login",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: "Email",
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                controller: _EmailController,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "Password",
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: Icon(Icons.remove_red_eye),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                controller: _PasswordController,
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: _SubmitData, child: const Text("submit")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
