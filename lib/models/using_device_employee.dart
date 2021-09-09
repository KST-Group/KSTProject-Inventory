// To parse this JSON data, do
//
//     final usingDeviceEmployee = usingDeviceEmployeeFromMap(jsonString);

import 'dart:convert';

UsingDeviceEmployee usingDeviceEmployeeFromMap(String str) =>
    UsingDeviceEmployee.fromMap(json.decode(str));

String usingDeviceEmployeeToMap(UsingDeviceEmployee data) =>
    json.encode(data.toMap());

class UsingDeviceEmployee {
  UsingDeviceEmployee({
    this.error,
    this.data,
    this.message,
  });

  bool? error;
  List<UsingEmployee>? data;
  String? message;

  factory UsingDeviceEmployee.fromMap(Map<String, dynamic> json) =>
      UsingDeviceEmployee(
        error: json["error"],
        data: List<UsingEmployee>.from(
            json["data"].map((x) => UsingEmployee.fromMap(x))),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "error": error,
        "data": List<dynamic>.from(data!.map((x) => x.toMap())),
        "message": message,
      };
}

class UsingEmployee {
  UsingEmployee({
    this.employeeId,
    this.gender,
    this.nameLa,
    this.nickname,
    this.nameEn,
    this.email,
    this.department,
    this.position,
    this.company,
    this.total,
  });

  String? employeeId;
  String? gender;
  String? nameLa;
  String? nickname;
  String? nameEn;
  String? email;
  String? department;
  String? position;
  String? company;
  int? total;

  factory UsingEmployee.fromMap(Map<String, dynamic> json) => UsingEmployee(
        employeeId: json["employeeId"],
        gender: json["gender"],
        nameLa: json["name_la"],
        nickname: json["nickname"],
        nameEn: json["name_en"],
        email: json["email"],
        department: json["department"],
        position: json["position"],
        company: json["company"],
        total: json["total"],
      );

  Map<String, dynamic> toMap() => {
        "employeeId": employeeId,
        "gender": gender,
        "name_la": nameLa,
        "name_en": nameEn,
        "email": email,
        "department": department,
        "position": position,
        "company": company,
        "total": total,
        "nickname": nickname,
      };
}
