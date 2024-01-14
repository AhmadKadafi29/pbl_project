import 'package:flutter/material.dart';
import 'package:pbl_project/DetailPembelian.dart';
import 'sharedPreferences.dart';
import 'PembelianModel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Pembelian extends StatefulWidget {
  Pembelian({super.key});

  @override
  State<Pembelian> createState() => _PembelianState();
}

class _PembelianState extends State<Pembelian> {
  Token token = Token();
  List<PembelianModel> pembelians = [];
  List<PembelianModel> filteredPembelians = [];
  TextEditingController searchController = TextEditingController();

  String endpoint = 'http://10.0.2.2:8000/api/pembelian';

  Future<List<PembelianModel>> fetchData() async {
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
          bodys['data']; // mengambil data list dari map dengan key data

      List<PembelianModel> pembelian =
          body.map((dynamic item) => PembelianModel.fromJson(item)).toList();
      return pembelian;
    } else {
      throw "Failed to load data";
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData().then((value) {
      setState(() {
        pembelians = value;
        filteredPembelians = value;
      });
    });
  }

  void filterPembelians(String query) {
    setState(() {
      filteredPembelians = pembelians
          .where((pembelian) =>
              pembelian.nama_obat.toLowerCase().contains(query.toLowerCase()))
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
                    "Halaman Pembelian",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            TextField(
              controller: searchController,
              onChanged: filterPembelians,
              decoration: const InputDecoration(
                hintText: "Cari Pembelian",
                filled: true,
                fillColor: Color.fromARGB(255, 230, 224, 224),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
          itemCount: filteredPembelians.length * 2,
          itemBuilder: (context, int i) {
            if (i.isOdd) return const Divider();
            final index = i ~/ 2;
            return ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Nama_Obat        :   ${filteredPembelians[index].nama_obat}",
                        style: const TextStyle(color: Colors.blue),
                      ),
                      Text(
                        "Nama_Supplier  :   ${filteredPembelians[index].nama_supplier}",
                        style: const TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPembelian(
                                  pembelian: filteredPembelians[index]),
                            ));
                      },
                      icon: Icon(Icons.more_horiz))
                ],
              ),
            );
          }),
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
}
