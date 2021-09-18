// To parse this JSON data, do
//
//     final userModel = userModelFromMap(jsonString);

import 'dart:convert';

UserModel userModelFromMap(String str) => UserModel.fromMap(json.decode(str));

String userModelToMap(UserModel data) => json.encode(data.toMap());

class UserModel {
  UserModel({
    this.error,
    this.data,
    this.message,
  });

  bool? error;
  List<User>? data;
  String? message;

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        error: json["error"],
        data: List<User>.from(json["data"].map((x) => User.fromMap(x))),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "error": error,
        "data": List<dynamic>.from(data!.map((x) => x.toMap())),
        "message": message,
      };
}

class User {
  User({
    this.username,
    this.passwords,
    this.surname,
    this.createDate,
    this.lastUpdate,
  });

  String? username;
  String? passwords;
  String? surname;
  DateTime? createDate;
  DateTime? lastUpdate;

  factory User.fromMap(Map<String, dynamic> json) => User(
        username: json["username"],
        passwords: json["passwords"],
        surname: json["surname"],
        createDate: DateTime.parse(json["create_date"]),
        lastUpdate: DateTime.parse(json["last_update"]),
      );

  Map<String, dynamic> toMap() => {
        "username": username ?? '',
        "passwords": passwords ?? '',
        "surname": surname ?? '',
        "create_date": createDate ?? '',
        "last_update": lastUpdate ?? '',
      };
}
