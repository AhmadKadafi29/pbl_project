import 'package:flutter/material.dart';
import 'PersonalModel.dart';
import 'sharedPreferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'EidtProfileModel.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _FullNameController = TextEditingController();
  final _EmailController = TextEditingController();
  final _AlamatController = TextEditingController();
  final _NotelfonController = TextEditingController();

  void _SubmitData() {
    final enteredName = _FullNameController.text;
    final enteredEmail = _EmailController.text;

    final enteredalamat = _AlamatController.text;
    final enterednotelp = _NotelfonController.text;

    if (enteredEmail.isEmpty ||
        enteredName.isEmpty ||
        enteredalamat.isEmpty ||
        enterednotelp.isEmpty) {
      return;
    }
    final ProfileModel User = ProfileModel(
        name: enteredName,
        email: enteredEmail,
        alamat: enteredalamat,
        no_telp: enterednotelp);
    _editProfile(User);
    Navigator.of(context).pop();
  }

  late List<Personal> personal = [];

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

  @override
  void initState() {
    super.initState();
    fetchData().then((value) {
      setState(() {
        personal = value;
        _FullNameController.text = personal.isNotEmpty ? personal[0].nama : "";
        _EmailController.text = personal.isNotEmpty ? personal[0].email : "";
        _AlamatController.text = personal.isNotEmpty ? personal[0].alamat : "";
        _NotelfonController.text =
            personal.isNotEmpty ? personal[0].no_telp : "";
      });
    });
  }

  Future<void> _editProfile(Personal) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/edit_profile'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${await token.getToken()}'
      },
      body: jsonEncode(Personal.toJson()),
    ); // post ke api dengan headers dan body  objek person to json dengan jsonencode

    if (response.statusCode == 201) {
    } else {
      throw "Failed to add data";
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
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 20),
                      child: TextField(
                        controller: _FullNameController,
                        decoration: const InputDecoration(
                            labelText: "Nama*",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)))),
                      )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 20),
                      child: TextField(
                        controller: _EmailController,
                        decoration: const InputDecoration(
                            labelText: "Email*",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)))),
                      )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 20),
                      child: TextField(
                        controller: _AlamatController,
                        decoration: const InputDecoration(
                            labelText: "Alamat*",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)))),
                      )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 20),
                      child: TextField(
                        controller: _NotelfonController,
                        decoration: const InputDecoration(
                            labelText: "No Telpon*",
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)))),
                      )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(onPressed: _SubmitData, child: Text("Simpan"))
        ],
      ),
    ));
  }
}
