import 'package:flutter/material.dart';

class TambahObat extends StatelessWidget {
  const TambahObat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 0),
              child: Text(
                "Tambah Data Obat",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
      body: const SingleChildScrollView(
        child: AddObat(),
      ),
      bottomNavigationBar: const BottomAppBar(
        height: 70,
        color: Color.fromARGB(255, 5, 217, 179),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Simpan",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}

class AddObat extends StatelessWidget {
  const AddObat({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Id Obat*"),
              Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: TextField(
                    decoration: InputDecoration(hintText: "Contoh : 1101"),
                  )),
              SizedBox(
                height: 10,
              ),
              Text("Nama Obat*"),
              Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: TextField(
                    decoration:
                        InputDecoration(hintText: "Contoh : Paracetamol"),
                  )),
              SizedBox(
                height: 10,
              ),
              Text("Jenis Obat*"),
              Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: TextField(
                    decoration: InputDecoration(hintText: "Contoh : Sirup"),
                  )),
              SizedBox(
                height: 10,
              ),
              Text("Kategori Obat*"),
              Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: TextField(
                    decoration:
                        InputDecoration(hintText: "Contoh : Obat Bebas"),
                  )),
              SizedBox(
                height: 10,
              ),
              Text("Stok Obat*"),
              Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: TextField(
                    decoration: InputDecoration(hintText: "Contoh :100"),
                  )),
              SizedBox(
                height: 10,
              ),
              Text("Harga Obat*"),
              Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: TextField(
                    decoration: InputDecoration(hintText: "Contoh :20000"),
                  )),
              SizedBox(
                height: 10,
              ),
              Text("Tanggal Masuk*"),
              Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: "Contoh : 12-10-2023",
                        suffixIcon: Icon(Icons.date_range)),
                  )),
              SizedBox(
                height: 10,
              ),
              Text("Exp Date*"),
              Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: "Contoh : 20-04-2025",
                        suffixIcon: Icon(Icons.date_range)),
                  )),
              SizedBox(
                height: 10,
              ),
              Text("Status*"),
              Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: TextField(
                    decoration: InputDecoration(hintText: "Contoh : aktif"),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
