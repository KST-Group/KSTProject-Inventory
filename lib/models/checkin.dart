// To parse this JSON data, do
//
//     final checkInDevice = checkInDeviceFromMap(jsonString);

import 'dart:convert';

CheckInDevice checkInDeviceFromMap(String str) => CheckInDevice.fromMap(json.decode(str));

String checkInDeviceToMap(CheckInDevice data) => json.encode(data.toMap());

class CheckInDevice {
  CheckInDevice({
    this.error,
    this.data,
    this.message,
  });

  bool? error;
  List<CheckIn>? data;
  String? message;

  factory CheckInDevice.fromMap(Map<String, dynamic> json) => CheckInDevice(
    error: json["error"],
    data: List<CheckIn>.from(json["data"].map((x) => CheckIn.fromMap(x))),
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "error": error,
    "data": List<dynamic>.from(data!.map((x) => x.toMap())),
    "message": message,
  };
}

class CheckIn {
  CheckIn({
    this.checkinId,
    this.checkInDate,
    this.username,
    this.employeeId,
  });

  String? checkinId;
  String? checkInDate;
  String? username;
  String? employeeId;

  factory CheckIn.fromMap(Map<String, dynamic> json) => CheckIn(
    checkinId: json["checkinId"],
    checkInDate: json["checkInDate"],
    username: json["username"],
    employeeId: json["employeeId"],
  );

  Map<String, dynamic> toMap() => {
    "checkinId": checkinId,
    "checkInDate": checkInDate??'',
    "username": username,
    "employeeId": employeeId,
  };
}
