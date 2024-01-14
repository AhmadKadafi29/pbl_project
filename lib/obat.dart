import 'package:flutter/material.dart';
import 'package:pbl_project/detailobat.dart';
import 'ObatModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'sharedPreferences.dart';

class Obat extends StatefulWidget {
  Obat({super.key});

  @override
  State<Obat> createState() => _ObatState();
}

class _ObatState extends State<Obat> {
  List<Medicine> obat = [];
  List<Medicine> filteredObat = [];
  String endpoint = 'http://10.0.2.2:8000/api/obat';
  Token token = Token();
  TextEditingController searchController = TextEditingController();

  Future<List<Medicine>> fetchData() async {
    final response = await http.get(
      Uri.parse(endpoint),
      headers: <String, String>{
        'Authorization': 'Bearer ${await token.getToken()}'
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> bodys = json.decode(response.body);
      List<dynamic> body = bodys['data'];

      List<Medicine> obats =
          body.map((dynamic item) => Medicine.fromJson(item)).toList();
      return obats;
    } else {
      throw "Failed to load data";
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData().then((value) {
      setState(() {
        obat = value;
        filteredObat = value;
      });
    });
  }

  void filterMedicines(String query) {
    setState(() {
      filteredObat = obat
          .where((medicine) =>
              medicine.nama_obat.toLowerCase().contains(query.toLowerCase()))
          .toList();
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
                    "Halaman Stok Obat",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
              child: TextField(
                controller: searchController,
                onChanged: filterMedicines,
                decoration: const InputDecoration(
                  hintText: "Cari Obat",
                  filled: true,
                  fillColor: Color.fromARGB(255, 230, 224, 224),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: filteredObat.length * 2,
        itemBuilder: (context, int i) {
          if (i.isOdd) return const Divider();
          final index = i ~/ 2;
          return ListTile(
            title: Text(filteredObat[index].nama_obat),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        child: Text(
                          "Harga  : ${filteredObat[index].harga_obat}",
                          style: const TextStyle(color: Colors.blue),
                        ),
                      ),
                      Text(
                        "Stok     : ${filteredObat[index].stok_obat}",
                        style: const TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailObat(
                            medicine: filteredObat[index],
                          ),
                        ),
                      );
                    },
                    icon: Icon(Icons.more_horiz),
                  ),
                ],
              ),
            ),
          );
        },
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
                    onPressed: () {},
                    icon: const Icon(Icons.home),
                    iconSize: 35,
                  ),
                  const Text(
                    "Home",
                    style: TextStyle(fontSize: 10),
                  ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
