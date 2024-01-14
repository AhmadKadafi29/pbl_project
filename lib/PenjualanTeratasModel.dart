class PenjualanTeratasmodel {
  String nama_obat;
 String total_penjualan;

  PenjualanTeratasmodel(
      {required this.nama_obat, required this.total_penjualan});

  factory PenjualanTeratasmodel.fromJson(Map<String, dynamic> json) {
    return PenjualanTeratasmodel(
        nama_obat: json['nama_obat'] as String,
        total_penjualan: json['total_penjualan'] as String);
  }
}
