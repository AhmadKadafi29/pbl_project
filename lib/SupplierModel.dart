class SupplierModel {
  int id_supplier;
  String nama_supplier;
  String alamat_supplier;
  String no_telp;

  SupplierModel({
    required this.id_supplier,
    required this.nama_supplier,
    required this.alamat_supplier,
    required this.no_telp,
  });

  factory SupplierModel.fromJson(Map<String, dynamic> json) {
    return SupplierModel(
      id_supplier: json['id'] as int,
      nama_supplier: json['nama_supplier'] as String,
      alamat_supplier: json['alamat'] as String,
      no_telp: json['no_telpon'] as String,
    );
  }
}
