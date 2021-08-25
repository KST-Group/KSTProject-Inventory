// To parse this JSON data, do
//
//     final employees = employeesFromMap(jsonString);

import 'dart:convert';

Employees employeesFromMap(String str) => Employees.fromMap(json.decode(str));

String employeesToMap(Employees data) => json.encode(data.toMap());

class Employees {
  Employees({
    this.error,
    this.data,
    this.message,
  });

  bool? error;
  List<Employee>? data;
  String? message;

  factory Employees.fromMap(Map<String, dynamic> json) => Employees(
    error: json["error"],
    data: List<Employee>.from(json["data"].map((x) => Employee.fromMap(x))),
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "error": error,
    "data": List<dynamic>.from(data!.map((x) => x.toMap())),
    "message": message,
  };
}

class Employee {
  Employee({
    this.employeeId,
    this.gender,
    this.nameLa,
    this.nameEn,
    this.nickname,
    this.email,
    this.position,
    this.department,
    this.company,
  });

  String? employeeId;
  String? gender;
  String? nameLa;
  String? nameEn;
  String? nickname;
  String? email;
  String? position;
  String? department;
  String? company;

  factory Employee.fromMap(Map<String, dynamic> json) => Employee(
    employeeId: json["employeeId"],
    gender: json["gender"],
    nameLa: json["name_la"],
    nameEn: json["name_en"],
    nickname: json["nickname"] == null ? null : json["nickname"],
    email: json["email"] == null ? null : json["email"],
    position: json["position"] == null ? null : json["position"],
    department: json["department"] == null ? null : json["department"],
    company: json["company"] == null ? null : json["company"],
  );

  Map<String, dynamic> toMap() => {
    "employeeId": employeeId,
    "gender": gender,
    "name_la": nameLa,
    "name_en": nameEn,
    "nickname": nickname == null ? null : nickname,
    "email": email == null ? null : email,
    "position": position == null ? null : position,
    "department": department == null ? null : department,
    "company": company == null ? null : company,
  };
}
