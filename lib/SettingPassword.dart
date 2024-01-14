import 'package:flutter/material.dart';
import 'sharedPreferences.dart';
import 'SettingPasswordModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SettingPassword extends StatefulWidget {
  const SettingPassword({super.key});

  @override
  State<SettingPassword> createState() => _SettingPasswordState();
}

class _SettingPasswordState extends State<SettingPassword> {
  Token token = Token();
  final _PasswordLamaController = TextEditingController();
  final _PasswordBaruController = TextEditingController();

  void _SubmitData() {
    final _enteredPasswordLama = _PasswordLamaController.text;
    final _enteredPasswordBaru = _PasswordBaruController.text;

    if (_enteredPasswordLama.isEmpty || _enteredPasswordBaru.isEmpty) {
      return;
    }

    final SettingPasswordModel SetPassword = SettingPasswordModel(
        password_lama: _enteredPasswordLama,
        password_baru: _enteredPasswordBaru);
    _updatePassword(SetPassword);
    Navigator.of(context).pop();
  }

  String endpoint = 'http://10.0.2.2:8000/api/profile/updatepassword';

  Future<void> _updatePassword(SettingPasswordModel password) async {
    final response = await http.post(Uri.parse(endpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${await token.getToken()}'
        },
        body: jsonEncode(password.toJson()));

    if (response.statusCode == 200) {
    } else {
      throw "Failed to set Password";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Password Lama*"),
                Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 20),
                    child: TextField(
                      controller: _PasswordLamaController,
                      decoration: const InputDecoration(
                          hintText: "********",
                          suffixIcon: Icon(Icons.remove_red_eye),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)))),
                    )),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Password Baru*"),
                Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                    child: TextField(
                      controller: _PasswordBaruController,
                      decoration: const InputDecoration(
                          hintText: "********",
                          suffixIcon: Icon(Icons.remove_red_eye),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)))),
                    )),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: _SubmitData, child: Text("Simpan"))
          ],
        ),
      ),
    );
  }
}
