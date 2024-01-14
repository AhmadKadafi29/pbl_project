class UsermodelRequest {
  String email;
  String password;
  UsermodelRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    return data;
  }

  factory UsermodelRequest.fromJson(Map<String, dynamic> json) {
    return UsermodelRequest(
      email: json['email'],
      password: json['password'],
    );
  }
}
