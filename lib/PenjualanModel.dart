class PenjualanModel {
  int id_penjualan;
  int id_obat;
  String nama_obat;
  int harga_obat;
  int jumlah;
  String total_harga;
  String tanggal_penjualan;

  PenjualanModel(
      {required this.id_penjualan,
      required this.id_obat,
      required this.nama_obat,
      required this.tanggal_penjualan,
      required this.jumlah,
      required this.total_harga,
      required this.harga_obat});

  factory PenjualanModel.fromJson(Map<String, dynamic> json) {
    return PenjualanModel(
      id_penjualan: json['id_penjualan'] as int,
      id_obat: json['id_obat'] as int,
      nama_obat: json['nama_obat'] as String,
      jumlah: json['jumlah'] as int,
      total_harga: json['total_harga'] as String,
      harga_obat: json['harga_obat'] as int,
      tanggal_penjualan: json['tanggal_penjualan'] as String,
    );
  }
}
