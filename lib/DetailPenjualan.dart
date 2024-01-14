import 'package:flutter/material.dart';
import 'PenjualanModel.dart';

class DetailPenjualan extends StatelessWidget {
  const DetailPenjualan({super.key, required this.penjualan});
  final PenjualanModel penjualan;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 0),
              child: Text(
                "Detail Data Penjualan",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('ID Penjualan:'),
                Text('${penjualan.id_penjualan}')
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Id Obat:'), Text('${penjualan.id_obat}')],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Nama_Obat:'),
                Text('${penjualan.nama_obat}')
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Harga_Obat :'), Text('${penjualan.harga_obat}')],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Jumlah:'),
                Text('${penjualan.jumlah}')
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Total_Harga:'), Text('${penjualan.total_harga}')],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tanggal_Penjualan:'),
                Text('${penjualan.tanggal_penjualan}')
              ],
            ),
          
          ],
        ),
      ),
    );
  }
}
