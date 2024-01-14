class ProfileModel {
  String name;
  String email;
  String alamat;
  String no_telp;

 ProfileModel({
    required this.name,
    required this.email,
    required this.alamat,
    required this.no_telp,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['alamat'] = alamat;
    data['no_telp'] = no_telp;

    return data;
  }
}
