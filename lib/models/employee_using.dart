// To parse this JSON data, do
//
//     final employeeUsing = employeeUsingFromMap(jsonString);

import 'dart:convert';

EmployeeUsing employeeUsingFromMap(String str) => EmployeeUsing.fromMap(json.decode(str));

String employeeUsingToMap(EmployeeUsing data) => json.encode(data.toMap());

class EmployeeUsing {
  EmployeeUsing({
    this.error,
    this.data,
    this.message,
  });

  bool? error;
  List<EmpUsing>? data;
  String? message;

  factory EmployeeUsing.fromMap(Map<String, dynamic> json) => EmployeeUsing(
    error: json["error"],
    data: List<EmpUsing>.from(json["data"].map((x) => EmpUsing.fromMap(x))),
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "error": error,
    "data": List<dynamic>.from(data!.map((x) => x.toMap())),
    "message": message,
  };
}

class EmpUsing {
  EmpUsing({
    this.checkoutId,
    this.checkOutDate,
    this.username,
    this.employeeId,
    this.checkoutdetailId,
    this.deviceId,
  });

  String? checkoutId;
  DateTime? checkOutDate;
  String? username;
  String? employeeId;
  int? checkoutdetailId;
  String? deviceId;

  factory EmpUsing.fromMap(Map<String, dynamic> json) => EmpUsing(
    checkoutId: json["checkoutId"],
    checkOutDate: DateTime.parse(json["checkOutDate"]),
    username: json["username"],
    employeeId: json["employeeId"],
    checkoutdetailId: json["checkoutdetailId"],
    deviceId: json["deviceId"],
  );

  Map<String, dynamic> toMap() => {
    "checkoutId": checkoutId,
    "checkOutDate": checkOutDate!.toIso8601String(),
    "username": username,
    "employeeId": employeeId,
    "checkoutdetailId": checkoutdetailId,
    "deviceId": deviceId,
  };
}
