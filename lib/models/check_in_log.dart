// To parse this JSON data, do
//
//     final checkInLogs = checkInLogsFromMap(jsonString);

import 'dart:convert';

CheckInLogs checkInLogsFromMap(String str) => CheckInLogs.fromMap(json.decode(str));

String checkInLogsToMap(CheckInLogs data) => json.encode(data.toMap());

class CheckInLogs {
  CheckInLogs({
    this.error,
    this.data,
    this.message,
  });

  bool? error;
  List<CheckInLog>? data;
  String? message;

  factory CheckInLogs.fromMap(Map<String, dynamic> json) => CheckInLogs(
    error: json["error"],
    data: List<CheckInLog>.from(json["data"].map((x) => CheckInLog.fromMap(x))),
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "error": error,
    "data": List<dynamic>.from(data!.map((x) => x.toMap())),
    "message": message,
  };
}

class CheckInLog {
  CheckInLog({
    this.logId,
    this.checkInDate,
    this.checkinId,
    this.deviceId,
    this.employeeId,
    this.descriptions,
  });

  int? logId;
  DateTime? checkInDate;
  String? checkinId;
  String? deviceId;
  String? employeeId;
  String? descriptions;

  factory CheckInLog.fromMap(Map<String, dynamic> json) => CheckInLog(
    logId: json["logId"],
    checkInDate: DateTime.parse(json["check_in_date"]),
    checkinId: json["checkinId"],
    deviceId: json["deviceId"],
    employeeId: json["employeeId"],
    descriptions: json["descriptions"],
  );

  Map<String, dynamic> toMap() => {
    "logId": logId??'',
    "check_in_date": checkInDate??'',
    "checkinId": checkinId??'',
    "deviceId": deviceId??'',
    "employeeId": employeeId??'',
    "descriptions": descriptions??'',
  };
}
