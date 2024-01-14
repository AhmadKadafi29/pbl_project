class Medicine {
  int id_obat;
  int kategori_obat_id;
  String nama_obat;
  String jenis_obat;
  String kategori_obat;
  int stok_obat;
  int harga_obat;
  String tanggal_masuk;
  String exp_date;
  String status;

  Medicine(
      {required this.id_obat,
      required this.nama_obat,
      required this.jenis_obat,
      required this.kategori_obat_id,
      required this.kategori_obat,
      required this.stok_obat,
      required this.harga_obat,
      required this.tanggal_masuk,
      required this.exp_date,
      required this.status});

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      id_obat: json['id_obat'] as int,
      kategori_obat_id: json['kategori_obat_id'] as int,
      nama_obat: json['nama_obat'] as String,
      jenis_obat: json['jenis_obat'] as String,
      kategori_obat: json['kategori_obat'] as String,
      stok_obat: json['stok_obat'] as int,
      harga_obat: json['harga_obat'] as int,
      tanggal_masuk: json['tanggal_masuk'] as String,
      exp_date: json['exp_date'] as String,
      status: json['status'] as String,
    );
  }
}
