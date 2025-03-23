class UserModel {
  String username;
  String email;
  String password;
  List<String>? roles;

  UserModel({
    required this.username,
    required this.email,
    required this.password,
    this.roles,
  });

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "email": email,
      "password": password,
      "roles": roles ?? ["user"], // Mặc định role là "user"
    };
  }
}
