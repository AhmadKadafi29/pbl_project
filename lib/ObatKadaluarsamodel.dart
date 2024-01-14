class ObatKadaluarsaModel {
  int id_obat_kadaluarsa;
  int id_obat;
  String nama_obat;
  String tanggal_kadaluarsa;

  ObatKadaluarsaModel(
      {required this.id_obat_kadaluarsa,
      required this.id_obat,
      required this.nama_obat,
      required this.tanggal_kadaluarsa});

  factory ObatKadaluarsaModel.fromJson(Map<String, dynamic> json) {
    return ObatKadaluarsaModel(
        id_obat_kadaluarsa: json['id_obat_kadaluarsa'] as int,
        id_obat: json['id_obat'] as int,
        nama_obat: json['nama_obat'] as String,
        tanggal_kadaluarsa: json['tanggal_kadaluarsa'] as String);
  }
}
