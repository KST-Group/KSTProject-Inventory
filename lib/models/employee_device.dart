// To parse this JSON data, do
//
//     final employessDevice = employessDeviceFromMap(jsonString);

import 'dart:convert';



class EmployeeDevice {
  EmployeeDevice({
    this.error,
    this.data,
    this.message,
  });

  bool? error;
  List<EmployeeDev>? data;
  String? message;

  factory EmployeeDevice.fromMap(Map<String, dynamic> json) => EmployeeDevice(
    error: json["error"],
    data: List<EmployeeDev>.from(json["data"].map((x) => EmployeeDev.fromMap(x))),
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "error": error,
    "data": List<dynamic>.from(data!.map((x) => x.toMap())),
    "message": message,
  };
}

class EmployeeDev {
  EmployeeDev({
    this.employeeId,
    this.gender,
    this.nameLa,
    this.nameEn,
    this.nickname,
    this.email,
    this.position,
    this.department,
    this.company,
    this.device,
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
  int? device;

  factory EmployeeDev.fromMap(Map<String, dynamic> json) => EmployeeDev(
    employeeId: json["employeeId"],
    gender: json["gender"],
    nameLa: json["name_la"],
    nameEn: json["name_en"],
    nickname: json["nickname"],
    email: json["email"],
    position: json["position"],
    department: json["department"],
    company: json["company"],
    device: json["device"],
  );

  Map<String, dynamic> toMap() => {
    "employeeId": employeeId,
    "gender": gender,
    "name_la": nameLa,
    "name_en": nameEn,
    "nickname": nickname,
    "email": email,
    "positionId": position,
    "departmentId": department,
    "companyId": company,
    "device": device,
  };
}
