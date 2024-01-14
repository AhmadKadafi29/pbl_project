class Personal {
  String nama;
  String email;
  String roles;
  String alamat;
  String no_telp;

  Personal({
    required this.nama,
    required this.email,
    required this.roles,
    required this.alamat,
    required this.no_telp,
  });

  factory Personal.fromJson(Map<String, dynamic> json) {
    return Personal(
        nama: json['name'],
        email: json['email'],
        roles: json['roles'],
        alamat: json['alamat'],
        no_telp: json['no_telp']);
  }
}
