// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.userId,
    required this.name,
    required this.email,
    this.profilePath,
    required this.balance,
    required this.hosted,
  });

  String userId;
  String name;
  String email;
  String? profilePath;
  int balance;
  int hosted;

  UserModel copyWith({
    String? userId,
    String? name,
    String? email,
    String? profilePath,
    int? balance,
    int? hosted,
  }) =>
      UserModel(
        userId: userId ?? this.userId,
        name: name ?? this.name,
        email: email ?? this.email,
        profilePath: profilePath ?? this.profilePath,
        balance: balance ?? this.balance,
        hosted: hosted ?? this.hosted,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json["user_id"],
        name: json["name"],
        email: json["email"],
        profilePath: json["profile_path"],
        balance: json["balance"],
        hosted: json["hosted"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "name": name,
        "email": email,
        "profile_path": profilePath,
        "balance": balance,
        "hosted": hosted,
      };
}
