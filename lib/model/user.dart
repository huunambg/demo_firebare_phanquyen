class Users {
  String? id;
  String? email;
  String? password;
  String? role;
  Users({this.id, this.email, this.password, this.role});

  Map<String, dynamic> toJson() =>
      {'id': id, 'email': email, 'password': password, 'role': role};
}
