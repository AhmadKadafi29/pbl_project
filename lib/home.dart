import 'package:flutter/material.dart';
import 'package:pbl_project/LaporanPembelian.dart';
import 'package:pbl_project/LaporanPenjualan.dart';
import 'package:pbl_project/ObatHampirKadaluarsa.dart';
import 'package:pbl_project/Opname.dart';
import 'package:pbl_project/Penjualan.dart';
import 'package:pbl_project/Profile.dart';
import 'package:pbl_project/obat.dart';
import 'Supplier.dart';
import 'User/GetUser.dart';
import 'Pembelian.dart';
import 'sharedPreferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'PenjualanTeratasModel.dart';
import 'ObatKadaluarsa.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'Sale.dart';

class Home extends StatefulWidget {
  final String username;
  const Home({super.key, this.username = ''});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Token token = Token();
  List<PenjualanTeratasmodel> penjualan = [];
  int totalPenjualanValue = 0;
  int totalKeuntunganValue = 0;
  GetUser user = GetUser();
  int selectMonth = 1;

  @override
  void initState() {
    super.initState();
    _initData(selectMonth);
  }

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
  List<Sale> Sales = [];

  Future<void> _initData(int month) async {
    int totalPenjualan = await SumPenjualan(month);
    setState(() {
      totalPenjualanValue = totalPenjualan;
    });

    int totalKeuntungan = await SumKeuntungan(month);
    setState(() {
      totalKeuntunganValue = totalKeuntungan;
    });

    List<PenjualanTeratasmodel> terlaris = await penjualanteratas(month);
    setState(() {
      penjualan = terlaris;
    });

    List<Sale> terjual = await SetStatistik(month);
    setState(() {
      Sales = terjual;
    });
  }

  Future<List<Sale>> SetStatistik(int id) async {
    final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/grafik/$id'),
        headers: <String, String>{
          "Authorization": 'Bearer ${await token.getToken()}'
        });
    if (response.statusCode == 200) {
      Map<String, dynamic> bodys = json.decode(response
          .body); //menyimpan data dari api ke map karena ada key dengan nanma data
      List<dynamic> body =
          bodys['data']; // mengambil data list dari map dengan key data

      List<Sale> sale =
          body.map((dynamic item) => Sale.fromJson(item)).toList();
      return sale;
    } else {
      throw "Failed to load data";
    }
  }

  Future<int> SumPenjualan(int id) async {
    final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/total_penjualan_perbulan/$id'),
        headers: <String, String>{
          "Authorization": 'Bearer ${await token.getToken()}'
        });
    if (response.statusCode == 200) {
      Map<String, dynamic> bodys = json.decode(response.body);
      int data = bodys["total_penjualan"];
      return data;
    } else {
      throw "Failed to load data";
    }
  }

  Future<int> SumKeuntungan(int id) async {
    final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/keuntungan_perbulan/$id'),
        headers: <String, String>{
          "Authorization": 'Bearer ${await token.getToken()}'
        });
    if (response.statusCode == 200) {
      Map<String, dynamic> bodys = json.decode(response.body);
      int data = bodys["total_keuntungan"];
      return data;
    } else {
      throw "Failed to load data";
    }
  }

  Future<List<PenjualanTeratasmodel>> penjualanteratas(int id) async {
    final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/penjualan_teratas/$id'),
        headers: <String, String>{
          "Authorization": 'Bearer ${await token.getToken()}'
        });
    if (response.statusCode == 200) {
      Map<String, dynamic> bodys = json.decode(response.body);
      List<dynamic> body = bodys['penjualan_teratas'];
      List<PenjualanTeratasmodel> nilai = body
          .map((dynamic item) => PenjualanTeratasmodel.fromJson(item))
          .toList();
      return nilai;
    } else {
      throw "Failed to load data";
    }
  }

  List<charts.Series<Sale, int>> _createSeries() {
    return [
      charts.Series<Sale, int>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        areaColorFn: (_, __) =>
            charts.MaterialPalette.blue.shadeDefault.lighter,
        domainFn: (Sale sale, _) => sale.day,
        measureFn: (Sale sale, _) => sale.penjualan,
        data: Sales,
      ),
      charts.Series<Sale, int>(
        id: 'Keuntungan',
        colorFn: (_, __) => charts.MaterialPalette.yellow.shadeDefault,
        areaColorFn: (_, __) =>
            charts.MaterialPalette.yellow.shadeDefault.lighter,
        domainFn: (Sale sale, _) => sale.day,
        measureFn: (Sale sale, _) => sale.keuntungan,
        data: Sales,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/logo.png',
                  height: 20,
                  width: 40,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    "SARKARA",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 100),
              child: Text(
                'Hi ${widget.username}',
                style: TextStyle(fontSize: 12),
              ),
            )
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: Colors.white,
            height: 1,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 100,
              child: Container(
                color: Colors.blue,
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 10),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Penjualan",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15, top: 12),
                              child: Text(
                                "$totalPenjualanValue",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 60, top: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Keuntungan",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20, top: 12),
                              child: Text(
                                "$totalKeuntunganValue",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 80),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Periode",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Container(
                                height: 30,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: DropdownButton<int>(
                                      value: selectMonth,
                                      items: List.generate(
                                          months.length,
                                          (index) => DropdownMenuItem<int>(
                                                value: index + 1,
                                                child: Text(months[index],
                                                    style: const TextStyle(
                                                        fontSize: 12)),
                                              )),
                                      onChanged: (value) async {
                                        setState(() {
                                          selectMonth = value!;
                                        });

                                        _initData(selectMonth);
                                      },
                                    )),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0, right: 0),
                      child: Card(
                        elevation: 4, // Mengatur tinggi shadow
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Container(
                          width: 380,
                          height: 180,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Obat()),
                                            );
                                          },
                                          child: Image.asset(
                                            'assets/obat.png',
                                            height: 35,
                                            width: 35,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        const Text(
                                          "Obat",
                                          style: TextStyle(fontSize: 12),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 25,
                                    ),
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Supplier()),
                                            );
                                          },
                                          child: Image.asset(
                                            'assets/supplier.png',
                                            height: 35,
                                            width: 35,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        const Text(
                                          "Supplier",
                                          style: TextStyle(fontSize: 12),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 25,
                                    ),
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const GetUser()),
                                            );
                                          },
                                          child: Image.asset(
                                            'assets/user.png',
                                            height: 35,
                                            width: 35,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        const Text(
                                          "User",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 25,
                                    ),
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Opname()));
                                          },
                                          child: Image.asset(
                                            'assets/opname.png',
                                            height: 35,
                                            width: 35,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        const Text(
                                          "Opname",
                                          style: TextStyle(fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Pembelian()),
                                            );
                                          },
                                          child: Image.asset(
                                            'assets/pembelian.png',
                                            height: 35,
                                            width: 35,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        const Text(
                                          "Pembelian",
                                          style: TextStyle(fontSize: 12),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 25,
                                    ),
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Penjualan()),
                                            );
                                          },
                                          child: Image.asset(
                                            'assets/penjualan.png',
                                            height: 35,
                                            width: 35,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        const Text(
                                          "Penjualan",
                                          style: TextStyle(fontSize: 12),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 25,
                                    ),
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LaporanPembelian()),
                                            );
                                          },
                                          child: Image.asset(
                                            'assets/lap pembelian.png',
                                            height: 35,
                                            width: 35,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        const Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Laporan",
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            Text(
                                              "Pembelian",
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 25,
                                    ),
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LaporanPenjualan()));
                                          },
                                          child: Image.asset(
                                            'assets/lap penjualan.png',
                                            height: 35,
                                            width: 35,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        const Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Laporan",
                                              style: TextStyle(fontSize: 12),
                                            ),
                                            Text(
                                              "Penjualan",
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: 380,
                      height: 50,
                      child: Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.blue),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              const Text(
                                "Penjualan Perbulan",
                                style: TextStyle(fontSize: 10),
                              ),
                              const SizedBox(
                                width: 50,
                              ),
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.yellow),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              const Text("Keuntungan Perbulan",
                                  style: TextStyle(fontSize: 10))
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 380,
                      child: Card(
                        elevation: 5, // Mengatur tinggi shadow
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Container(
                          height: 300,
                          padding: EdgeInsets.all(16),
                          child: charts.LineChart(
                            _createSeries(),
                            animate: true,
                            animationDuration: Duration(seconds: 5),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Card(
                  child: Container(
                    width: 380,
                    height: 80,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10, left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 50,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 225, 224, 224),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        'assets/expired.png',
                                        height: 30,
                                        width: 30,
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: 8, left: 12),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ObatKadaluarsa()));
                                          },
                                          child: const Text(
                                            "Kadaluarsa",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 50,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 225, 224, 224),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        'assets/deadline.png',
                                        height: 30,
                                        width: 30,
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: 2, left: 20),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ObatHampirKadaluarsa()));
                                          },
                                          child: const Text(
                                            "   Hampir\nKadaluarsa",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 1,
              width: 380,
              color: Color.fromARGB(255, 203, 197, 197),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              elevation: 5,
              child: Container(
                width: 380,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Obat Terlaris",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Card(
                        child: Container(
                          color: Colors.blue.withOpacity(0.8),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("No",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text("Nama Obat",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text("Terjual",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      if (penjualan.isNotEmpty)
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: penjualan.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 5,
                              child: Container(
                                height: 40,
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 17, right: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("${index + 1}"),
                                      Text("${penjualan[index].nama_obat}"),
                                      Text(
                                          "${penjualan[index].total_penjualan}")
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      else
                        const SizedBox()
                    ],
                  ),
                ),
              ),
            )
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Profile(),
                          settings: RouteSettings(
                              arguments: {'username': widget.username}),
                        ),
                      );
                    },
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
