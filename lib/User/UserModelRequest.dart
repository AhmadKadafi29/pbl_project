class UserModelReq {
  String name;
  String email;
  String password;
  String roles;
  String alamat;
  String no_telp;

  UserModelReq({
    required this.name,
    required this.email,
    required this.password,
    required this.roles,
    required this.alamat,
    required this.no_telp,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['roles'] = roles;
     data['alamat'] = alamat;
    data['no_telp'] = no_telp;

    return data;
  }
}
