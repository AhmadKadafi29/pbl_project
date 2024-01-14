class OpnameModel {
  int id_opname;
  int id_obat;
  int id_user;
  String nama_user;
  String nama_obat;
  int stok_fisik;
  String status;
  String tanggal_kadaluarsa;

  OpnameModel({
    required this.id_opname,
    required this.nama_obat,
    required this.id_obat,
    required this.status,
    required this.nama_user,
    required this.stok_fisik,
   required this.id_user,
    required this.tanggal_kadaluarsa,
  });
  factory OpnameModel.fromJson(Map<String, dynamic> json) {
    return OpnameModel(
      id_opname: json['id_opname'] as int,
      id_obat: json['id_obat'] as int,
      nama_obat: json['nama_obat'] as String,
      id_user: json['id_user'] as int,
      nama_user: json['nama_user'] as String,
      stok_fisik: json['stok_fisik'] as int,
      tanggal_kadaluarsa: json['tanggal_kadaluarsa'] as String,
      status: json['status'] as String,
    );
  }
}
