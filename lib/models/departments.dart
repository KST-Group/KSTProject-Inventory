// To parse this JSON data, do
//
//     final departments = departmentsFromMap(jsonString);

import 'dart:convert';

Departments departmentsFromMap(String str) => Departments.fromMap(json.decode(str));

String departmentsToMap(Departments data) => json.encode(data.toMap());

class Departments {
  Departments({
    this.error,
    this.data,
    this.message,
  });

  bool? error;
  List<Department>? data;
  String? message;

  factory Departments.fromMap(Map<String, dynamic> json) => Departments(
    error: json["error"],
    data: List<Department>.from(json["data"].map((x) => Department.fromMap(x))),
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "error": error,
    "data": List<dynamic>.from(data!.map((x) => x.toMap())),
    "message": message,
  };
}

class Department {
  Department({
    this.departmentId,
    this.department,
    this.companyId,
    this.description,
  });

  int? departmentId;
  String? department;
  int? companyId;
  String? description;

  factory Department.fromMap(Map<String, dynamic> json) => Department(
    departmentId: json["departmentId"],
    department: json["department"],
    companyId: json["companyId"],
    description:json['description'],
  );

  Map<String, dynamic> toMap() => {
    "departmentId": departmentId,
    "department": department,
    "companyId": companyId,
    "description":description,
  };
}
