import 'package:flutter/material.dart';
import 'package:pbl_project/ObatKadaluarsamodel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'sharedPreferences.dart';

class ObatKadaluarsa extends StatefulWidget {
  ObatKadaluarsa({super.key});

  @override
  State<ObatKadaluarsa> createState() => _ObatKadaluarsaState();
}

class _ObatKadaluarsaState extends State<ObatKadaluarsa> {
  List<ObatKadaluarsaModel> obat = [];
  String endpoint = 'http://10.0.2.2:8000/api/obat_kadaluarsa';
  Token token = Token();

  Future<List<ObatKadaluarsaModel>> fetchData() async {
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

      List<ObatKadaluarsaModel> obats = body
          .map((dynamic item) => ObatKadaluarsaModel.fromJson(item))
          .toList();
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
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        toolbarHeight: 100,
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 5, bottom: 5),
              child: Row(
                children: [
                  Text(
                    "Halaman Obat Kadaluarsa",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
              child: TextField(
                decoration: InputDecoration(
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
          itemCount: obat.length * 2,
          itemBuilder: (context, int i) {
            if (i.isOdd) return const Divider();
            final index = i ~/ 2;
            return ListTile(
              title: Text(obat[index].nama_obat),
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
                            "Tanggal_Kadaluarsa  : ${obat[index].tanggal_kadaluarsa}",
                            style: const TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                    // IconButton(
                    //     onPressed: () {
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) => DetailObat(
                    //             medicine: obat[index].tanggal_kadaluarsa,
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //     icon: Icon(Icons.more_horiz))
                  ],
                ),
              ),
            );
          }),
    );
  }
}
