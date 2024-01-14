import 'package:flutter/material.dart';
import 'SupplierModel.dart';


class DetailSupplier extends StatelessWidget {
  const DetailSupplier({super.key, required this.supplierModel});
  final SupplierModel supplierModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 0),
              child: Text(
                "Detail Data Supplier",
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
              children: [Text('ID Supplier:'), Text('${supplierModel.id_supplier}')],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Nama Supplier:'), Text('${supplierModel.nama_supplier}')],
            ),
            const SizedBox(
              height: 10,
            ),
           
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Alamat Supplier:'), Text('${supplierModel.alamat_supplier}')],
            ),
            const SizedBox(
              height: 10,
            ),
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('No_telp:'), Text('${supplierModel.no_telp}')],
            ),
           
          ],
        ),
      ),
    );
  }
}
