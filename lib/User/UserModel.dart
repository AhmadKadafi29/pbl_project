class UserModel {
  int id;
  String name;
  String email;
  String roles;
  String alamat;
  String no_telp;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.roles,
    required this.alamat,
    required this.no_telp,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        roles: json['roles'],
        alamat: json['alamat'],
        no_telp: json['no_telp']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['roles'] = roles;
    data['alamat'] = alamat;
    data['no_telp'] = no_telp;

    return data;
  }
}
