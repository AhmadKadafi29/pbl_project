class Sale {
  double penjualan;
  int id_obat;
  int keuntungan;
  int day;

  Sale({required this.penjualan, required this.day, required this.id_obat, required this.keuntungan});

  factory Sale.fromJson(Map<String, dynamic> json) {
    return Sale(
      penjualan: double.parse(json['total_harga']),
      day: json['day'] as int,
      id_obat: json['id_obat'] as int,
      keuntungan: json['keuntungan'] as int
    );
  }
}
