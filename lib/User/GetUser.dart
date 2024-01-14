import 'package:flutter/material.dart';
import 'UserModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pbl_project/User/AddUser.dart';
import 'EditUser.dart';
import 'package:pbl_project/sharedPreferences.dart';

class GetUser extends StatefulWidget {
  const GetUser({super.key});

  @override
  State<GetUser> createState() => _GetUserState();
}

class _GetUserState extends State<GetUser> {
  List<UserModel> users = [];
  Token token = Token();

  String endpoint = 'http://10.0.2.2:8000/api/user';

  Future<List<UserModel>> fetchData() async {
    final response = await http.get(
      Uri.parse(endpoint),
      headers: <String, String>{
        'Authorization': 'Bearer ${await token.getToken()}'
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> bodys = json.decode(response
          .body); //menyimpan data dari api ke map karena ada key dengan nanma data
      List<dynamic> body =
          bodys['user']; // mengambil data list dari map dengan key data

      List<UserModel> User =
          body.map((dynamic item) => UserModel.fromJson(item)).toList();
      return User;
    } else {
      throw "Failed to load data";
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData().then((value) {
      setState(() {
        users = value;
      });
    });
  }

  Future<void> _removeItem(int id) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/user/$id'),
      headers: <String, String>{
        'Authorization': 'Bearer ${await token.getToken()}'
      },
    ); // menghapus data deng an id di api
    if (response.statusCode == 200) {
      setState(() {
        users.removeWhere((item) =>
            item.id == id); // menghapus data di list data dan mengubah statenya
      });
    } else {
      throw "Failed to delete data";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data User"),
      ),
      body: ListView.builder(
          itemCount: users.length * 2,
          itemBuilder: (context, int i) {
            if (i.isOdd) return const Divider();
            final index = i ~/ 2;
            return Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ListTile(
                title: Text(users[index].name),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        _removeItem(users[index].id);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditUser(
                                      id: users[index].id,
                                    )));
                      },
                    ),
                  ],
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Id User       :   ${users[index].id}",
                            style: const TextStyle(color: Colors.blue),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Email          :   ${users[index].email}",
                            style: const TextStyle(color: Colors.blue),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Roles          :   ${users[index].roles}",
                            style: const TextStyle(color: Colors.blue),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "alamat        :   ${users[index].alamat}",
                            style: const TextStyle(color: Colors.blue),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "No_Telp      :   ${users[index].no_telp}",
                            style: const TextStyle(color: Colors.blue),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
      floatingActionButton: Container(
        margin: const EdgeInsets.all(15),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddUser()));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
