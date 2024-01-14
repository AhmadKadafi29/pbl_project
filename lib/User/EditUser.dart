import 'package:flutter/material.dart';
import 'package:pbl_project/User/UserModelRequest.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pbl_project/sharedPreferences.dart';

// ignore: must_be_immutable
class EditUser extends StatefulWidget {
  int id;
  EditUser({super.key, required this.id});

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  Token token = Token();
  final _FullNameController = TextEditingController();
  final _EmailController = TextEditingController();
  final _PasswordController = TextEditingController();
  final _RolesController = TextEditingController();
  final _AlamatController = TextEditingController();
  final _NotelfonController = TextEditingController();

  void _SubmitData() {
    final enteredName = _FullNameController.text;
    final enteredEmail = _EmailController.text;
    final enteredPassword = _PasswordController.text;
    final enteredRoles = _RolesController.text;
    final enteredalamat = _AlamatController.text;
    final enterednotelp = _NotelfonController.text;

    if (enteredEmail.isEmpty ||
        enteredPassword.isEmpty ||
        enteredName.isEmpty ||
        enteredRoles.isEmpty ||
        enteredalamat.isEmpty ||
        enterednotelp.isEmpty) {
      return;
    }
    final UserModelReq User = UserModelReq(
        name: enteredName,
        email: enteredEmail,
        password: enteredPassword,
        roles: enteredRoles,
        alamat: enteredalamat,
        no_telp: enterednotelp);
    _editUser(User, widget.id);
    Navigator.of(context).pop();
  }

  Future<void> _editUser(UserModelReq user, int id) async {
    final response = await http.put(
      Uri.parse('http://10.0.2.2:8000/api/user/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${await token.getToken()}'
      },
      body: jsonEncode(user.toJson()),
    ); // post ke api dengan headers dan body  objek person to json dengan jsonencode

    if (response.statusCode == 201) {
    } else {
      throw "Failed to add data";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit User"),
        ),
        body: Padding(
          padding: EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Nama *"),
                    Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: TextField(
                          controller: _FullNameController,
                          decoration: InputDecoration(hintText: ""),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("Email *"),
                    Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: TextField(
                          controller: _EmailController,
                          decoration: InputDecoration(hintText: ""),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("Password *"),
                    Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: TextField(
                          controller: _PasswordController,
                          decoration: InputDecoration(hintText: ""),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("Roles *"),
                    Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: TextField(
                          controller: _RolesController,
                          decoration: InputDecoration(hintText: ""),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("Alamat *"),
                    Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: TextField(
                          controller: _AlamatController,
                          decoration: InputDecoration(hintText: ""),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("No_Telp *"),
                    Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: TextField(
                          controller: _NotelfonController,
                          decoration: InputDecoration(hintText: ""),
                        )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 250, top: 20),
                  child: ElevatedButton(
                      onPressed: _SubmitData, child: Text("Simpan")),
                )
              ],
            ),
          ),
        ));
  }
}
