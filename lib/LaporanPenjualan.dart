import 'package:flutter/material.dart';
import 'sharedPreferences.dart';
import 'PenjualanModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LaporanPenjualan extends StatefulWidget {
  const LaporanPenjualan({super.key});

  @override
  State<LaporanPenjualan> createState() => _LaporanPenjualanState();
}

class _LaporanPenjualanState extends State<LaporanPenjualan> {
  TextEditingController SearchController = TextEditingController();
  int selectMonth = 1;
  Token token = Token();
  int selectYear = DateTime.now().year;
  List<String> months = [
    "Januari",
    "Februari",
    "Maret",
    "April",
    "Mei",
    "Juni",
    "Juli",
    "Agustus",
    "September",
    "Oktober",
    "November",
    "Desember",
  ];
  int hasil = 0;
  List<PenjualanModel> penjualan = [];
  List<PenjualanModel> FilteredData = [];
  @override
  void initState() {
    super.initState();
    _initMonthDropdown(selectMonth);
    _initYearDropdown(selectYear);
  }

  Future<void> _initMonthDropdown(int month) async {
    await _loadPenjualanData(month, selectYear);
  }

  Future<void> _initYearDropdown(int year) async {
    await _loadPenjualanData(selectMonth, year);
  }

  Future<void> _loadPenjualanData(int month, int year) async {
    try {
      List<PenjualanModel> totalPenjualan = await getPenjualan(month, year);
      setState(() {
        penjualan = totalPenjualan;
      });
      int total = await SumPenjualan(month, year); // Swap month and year here
      setState(() {
        hasil = total;
      });
    } catch (error) {
      print("Error loading data: $error");
    }
  }

  Future<List<PenjualanModel>> getPenjualan(int id, int tahun) async {
    final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/laporan_penjualan/$id/$tahun'),
        headers: <String, String>{
          "Authorization": 'Bearer ${await token.getToken()}'
        });
    if (response.statusCode == 200) {
      Map<String, dynamic> bodys = json.decode(response
          .body); //menyimpan data dari api ke map karena ada key dengan nanma data
      List<dynamic> body =
          bodys['data']; // mengambil data list dari map dengan key data

      List<PenjualanModel> sale =
          body.map((dynamic item) => PenjualanModel.fromJson(item)).toList();
      return sale;
    } else {
      throw "Failed to load data";
    }
  }

  Future<int> SumPenjualan(int id, int year) async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/total_penjualan/$id/$year'),
      headers: <String, String>{
        "Authorization": 'Bearer ${await token.getToken()}'
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      int data = body["total_penjualan"];
      return data;
    } else {
      throw "Failed to load data";
    }
  }

  void FilterPenjualan(String query) {
    setState(() {
      if (query.isEmpty) {
        _loadPenjualanData(selectMonth, selectYear);
      } else {
        penjualan = penjualan
            .where((PenjualanModel) => PenjualanModel.nama_obat
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
                    "Laporan Penjualan",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            TextField(
              controller: SearchController,
              onChanged: FilterPenjualan,
              decoration: const InputDecoration(
                hintText: "Cari Data",
                filled: true,
                fillColor: Color.fromARGB(255, 230, 224, 224),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              elevation: 5,
              child: Container(
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    top: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          const Text(
                            "Bulan",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          DropdownButton<int>(
                            value: selectMonth,
                            items: List.generate(
                                months.length,
                                (index) => DropdownMenuItem<int>(
                                      value: index + 1,
                                      child: Text(months[index],
                                          style: const TextStyle(fontSize: 12)),
                                    )),
                            onChanged: (value) async {
                              setState(() {
                                selectMonth = value!;
                                _initMonthDropdown(selectMonth);
                              });
                            },
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      Column(
                        children: [
                          const Text(
                            "Tahun",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          DropdownButton<int>(
                            value: selectYear,
                            items: List.generate(
                              10, // Ganti sesuai kebutuhan rentang tahun yang diinginkan
                              (index) => DropdownMenuItem<int>(
                                value: DateTime.now().year - index,
                                child: Text(
                                  (DateTime.now().year - index).toString(),
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                            onChanged: (value) async {
                              setState(() {
                                selectYear = value!;
                                _initYearDropdown(selectYear);
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (penjualan.isNotEmpty)
              Container(
                height: 550,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: penjualan.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Nama Obat                  : ${penjualan[index].nama_obat}",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
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
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                  child: Text(
                                    "Id Penjualan                      :   ${penjualan[index].id_penjualan}",
                                    style: const TextStyle(color: Colors.blue),
                                  ),
                                ),
                                Text(
                                  "Jumlah Jual                      :   ${penjualan[index].jumlah}",
                                  style: const TextStyle(color: Colors.blue),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Tanggal Penjualan           :   ${penjualan[index].tanggal_penjualan}",
                                      style:
                                          const TextStyle(color: Colors.blue),
                                    ),
                                    const SizedBox(
                                      width: 50,
                                    ),
                                    Text(
                                      " Rp ${penjualan[index].total_harga}",
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            // IconButton(
                            //     onPressed: () {
                            //       Navigator.push(
                            //           context,
                            //           MaterialPageRoute(
                            //             builder: (context) => DetailPenjualan(
                            //                 penjualan: penjualan[index]),
                            //           ));
                            //     },
                            //     icon: Icon(Icons.more_horiz))
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            if (penjualan.isEmpty)
              const Center(
                child: SizedBox(),
              ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 80,
        child: Padding(
          padding: const EdgeInsets.only(left: 170, right: 0, top: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    "Total Penjualan : ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Rp ${hasil}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
