import 'package:learn_connect/data/models/UserInfor.dart';

class UserModel {
  String username;
  String email;
  String password;
  List<String>? roles;
  final UserInfo? userInfo;

  UserModel({
    required this.username,
    required this.email,
    required this.password,
    this.roles,
    this.userInfo,

  });

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "email": email,
      "password": password,
      "roles": roles ?? ["user"], // Mặc định role là "user"
    };
  }
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'],
      email: json['email'],
      password: json['password'],
      roles: List<String>.from(json['roles']),
      userInfo: json['userInfo'] != null ? UserInfo.fromJson(json['userInfo']) : null,

    );
  }
}
