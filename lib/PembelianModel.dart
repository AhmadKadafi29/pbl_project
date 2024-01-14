
class PembelianModel {
  int id_pembelian;
  int id_obat;
  int id_supplier;
  int nofaktur;
  int harga_satuan;
  int quantity;
  int total_harga;
  String tanggal_pembelian;
  String status_pembayaran;
 String nama_obat;
  String  nama_supplier;

  PembelianModel(
      {required this.id_pembelian,
      required this.id_obat,
      required this.id_supplier,
      required this.nofaktur,
      required this.harga_satuan,
      required this.quantity,
      required this.total_harga,
      required this.tanggal_pembelian,
      required this.status_pembayaran,
      required this.nama_obat,
      required this.nama_supplier});

  factory PembelianModel.fromJson(Map<String, dynamic> json) {
    return PembelianModel(
      id_pembelian: json['id_pembelian'] as int,
      id_obat: json['id_obat'] as int,
      id_supplier: json['id_supplier'] as int,
      nofaktur: json['nofaktur'] as int,
      harga_satuan: json['harga_satuan'] as int,
      quantity: json['quantity'] as int,
      total_harga: json['total_harga'] as int,
      tanggal_pembelian: json['tanggal_pembelian'] as String,
      status_pembayaran: json['status_pembayaran'] as String,
     nama_obat: json['nama_obat'] as String,
     nama_supplier: json['nama_supplier'] as String
    );
  }
}
