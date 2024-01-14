import 'package:flutter/material.dart';
import 'OpnameModel.dart';
import 'sharedPreferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Opname extends StatefulWidget {
  Opname({super.key});

  @override
  State<Opname> createState() => _OpnameState();
}

class _OpnameState extends State<Opname> {
  List<OpnameModel> opname = [];

  String endpoint = 'http://10.0.2.2:8000/api/opname';

  Token token = Token();

  TextEditingController searchController = TextEditingController();

  Future<List<OpnameModel>> fetchData() async {
    final response = await http.get(
      Uri.parse(endpoint),
      headers: <String, String>{
        'Authorization': 'Bearer ${await token.getToken()}'
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> bodys = json.decode(response.body);
      List<dynamic> body = bodys['data'];

      List<OpnameModel> data =
          body.map((dynamic item) => OpnameModel.fromJson(item)).toList();
      return data;
    } else {
      throw "Failed to load data";
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData().then((value) {
      setState(() {
        opname = value;
      });
    });
  }

  void filteredopname(String query) {
    setState(() {
      if (query.isEmpty) {
        fetchData().then((value) {
          setState(() {
            opname = value;
          });
        });
      } else {
        opname = opname
            .where((OpnameModel) => OpnameModel.nama_obat
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              child: Row(
                children: [
                  Text(
                    "Halaman Opname",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            TextField(
              controller: searchController,
              onChanged: filteredopname,
              decoration: const InputDecoration(
                hintText: "Cari Opname",
                filled: true,
                fillColor: Color.fromARGB(255, 230, 224, 224),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
          itemCount: opname.length * 2,
          itemBuilder: (context, int i) {
            if (i.isOdd) return const Divider();
            final index = i ~/ 2;
            return ListTile(
              title: Text(opname[index].nama_obat),
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
                          "id_opname: ${opname[index].id_opname}",
                          style: const TextStyle(color: Colors.blue),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            "tanggal_kadaluarsa: ${opname[index].tanggal_kadaluarsa}",
                            style: const TextStyle(color: Colors.blue),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Text(
                            "nama_user: ${opname[index].nama_user}",
                            style: const TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
