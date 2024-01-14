class SettingPasswordModel {
  String password_lama;
  String password_baru;

  SettingPasswordModel(
      {required this.password_lama, required this.password_baru});


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['password_lama'] = password_lama;
    data['password_baru'] = password_baru;

    return data;
  }
}
