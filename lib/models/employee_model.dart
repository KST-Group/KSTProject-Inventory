// To parse this JSON data, do
//
//     final employeeModel = employeeModelFromMap(jsonString);

import 'dart:convert';

EmployeeModel employeeModelFromMap(String str) => EmployeeModel.fromMap(json.decode(str));

String employeeModelToMap(EmployeeModel data) => json.encode(data.toMap());

class EmployeeModel {
  EmployeeModel({
    this.error,
    this.data,
    this.message,
  });

  bool? error;
  List<EmpModel>? data;
  String? message;

  factory EmployeeModel.fromMap(Map<String, dynamic> json) => EmployeeModel(
    error: json["error"],
    data: List<EmpModel>.from(json["data"].map((x) => EmpModel.fromMap(x))),
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "error": error,
    "data": List<dynamic>.from(data!.map((x) => x.toMap())),
    "message": message,
  };
}

class EmpModel {
  EmpModel({
    this.employeeId,
    this.nameLa,
    this.gender,
    this.nameEn,
    this.nickname,
    this.email,
    this.departmentId,
    this.positionId,
    this.companyId,
  });

  String? employeeId;
  String? nameLa;
  String? gender;
  String? nameEn;
  String? nickname;
  String? email;
  String? departmentId;
  String? positionId;
  String? companyId;

  factory EmpModel.fromMap(Map<String, dynamic> json) => EmpModel(
    employeeId: json["employeeId"],
    nameLa: json["name_la"],
    gender: json["gender"],
    nameEn: json["name_en"],
    nickname: json["nickname"],
    email: json["email"],
    departmentId: json["departmentId"],
    positionId: json["positionId"],
    companyId: json["companyId"],
  );

  Map<String, dynamic> toMap() => {
    "employeeId": employeeId,
    "name_la": nameLa??'',
    "gender": gender??'',
    "name_en": nameEn??'',
    "nickname": nickname??'',
    "email": email??'',
    "departmentId": departmentId??'',
    "positionId": positionId??'',
    "companyId": companyId??'',
  };
}
