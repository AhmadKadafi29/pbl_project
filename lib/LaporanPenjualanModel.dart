class LapPenjualanModel {
  int total_keuntungan;

  LapPenjualanModel({required this.total_keuntungan});

  factory LapPenjualanModel.fromJson(
      Map<String, dynamic> json) {
    return LapPenjualanModel(
      total_keuntungan: json['total_penjualan'] as int,
    );
  }
}
