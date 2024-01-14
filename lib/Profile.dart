import 'package:flutter/material.dart';
import 'package:pbl_project/EditProfile.dart';
import 'package:pbl_project/Personalnfo.dart';
import 'package:pbl_project/SettingPassword.dart';
import 'package:pbl_project/home.dart';
import 'sharedPreferences.dart';
import 'Logout.dart';
import 'login_page.dart';
import 'PersonalModel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Logout logout = Logout();
  Token token = Token();
  int selectedIndex = 0;
  late List<Personal> personal = [];

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
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [
          TextButton(
            onPressed: () {
              logout.logoutUser();
              token.Logout();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
            child: const Text(
              "Log out",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: Colors.white,
            height: 1,
          ),
        ),
      ),
      body: Container(
        // color: Color.fromARGB(255, 216, 206, 206),
        child: Column(
          children: [
            Container(
              color: Colors.blue,
              height: 240,
              child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: personal.isNotEmpty
                      ? Column(
                          children: [
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Icon(
                                Icons.person,
                                size: 60,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${personal[0].nama}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("${personal[0].roles}",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold)),
                            const SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 20, left: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildButton("Profile Info", 0),
                                  _buildButton("Edit Profile", 1),
                                  _buildButton("Setting", 2),
                                ],
                              ),
                            ),
                          ],
                        )
                      : SizedBox()),
            ),
            Expanded(
              child: IndexedStack(
                index: selectedIndex,
                children: [PersonalInfo(), EditProfile(), SettingPassword()],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 80,
        child: Padding(
          padding: const EdgeInsets.only(left: 80, right: 80, top: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Home()));
                    },
                    icon: const Icon(Icons.home),
                    iconSize: 35,
                  ),
                  const Text(
                    "Home",
                    style: TextStyle(fontSize: 10),
                  )
                ],
              ),
              Column(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.person),
                    iconSize: 35,
                  ),
                  const Text(
                    "Profile",
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String text, int index) {
    bool isHighlighted = selectedIndex == index;

    return Container(
      height: 30,
      width: 100,
      child: Material(
        color: isHighlighted ? Colors.white : Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight:
                      isHighlighted ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
