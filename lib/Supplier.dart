import 'package:flutter/material.dart';
import 'package:pbl_project/DetailSupplier.dart';
import 'SupplierModel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'sharedPreferences.dart';

class Supplier extends StatefulWidget {
  Supplier({super.key});

  @override
  State<Supplier> createState() => _SupplierState();
}

class _SupplierState extends State<Supplier> {
  List<SupplierModel> supplier = [];
  List<SupplierModel> filteredSupplier = [];
  String endpoint = 'http://10.0.2.2:8000/api/supplier';
  Token token = Token();
  TextEditingController searchController = TextEditingController();

  Future<List<SupplierModel>> fetchData() async {
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

      List<SupplierModel> suppliers =
          body.map((dynamic item) => SupplierModel.fromJson(item)).toList();
      return suppliers;
    } else {
      throw "Failed to load data";
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData().then((value) {
      setState(() {
        supplier = value;
        filteredSupplier = value;
      });
    });
  }
  
  void filterSupplier(String query) {
    setState(() {
      filteredSupplier = supplier
          .where((supplier) =>
              supplier.nama_supplier.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title:  Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              child: Row(
                children: [
                  Text(
                    "Halaman Supplier",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
              child: TextField(
                controller: searchController,
                onChanged: filterSupplier,
                decoration: const InputDecoration(
                  hintText: "Cari Supplier",
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
          itemCount: filteredSupplier.length * 2,
          itemBuilder: (context, int i) {
            if (i.isOdd) return const Divider();
            final index = i ~/ 2;
            return ListTile(
              title: Text(filteredSupplier[index].nama_supplier),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "No_Telp: ${filteredSupplier[index].no_telp}",
                        style: const TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailSupplier(
                                supplierModel:filteredSupplier[index],
                              ),
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
