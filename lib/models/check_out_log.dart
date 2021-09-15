// To parse this JSON data, do
//
//     final checkOutLogs = checkOutLogsFromMap(jsonString);

import 'dart:convert';

CheckOutLogs checkOutLogsFromMap(String str) => CheckOutLogs.fromMap(json.decode(str));

String checkOutLogsToMap(CheckOutLogs data) => json.encode(data.toMap());

class CheckOutLogs {
  CheckOutLogs({
    this.error,
    this.data,
    this.message,
  });

  bool? error;
  List<OutLog>? data;
  String? message;

  factory CheckOutLogs.fromMap(Map<String, dynamic> json) => CheckOutLogs(
    error: json["error"],
    data: List<OutLog>.from(json["data"].map((x) => OutLog.fromMap(x))),
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "error": error,
    "data": List<dynamic>.from(data!.map((x) => x.toMap())),
    "message": message,
  };
}

class OutLog {
  OutLog({
    this.logId,
    this.checkOutDate,
    this.checkoutId,
    this.deviceId,
    this.employeeId,
  });

  int? logId;
  DateTime? checkOutDate;
  String? checkoutId;
  String? deviceId;
  String? employeeId;

  factory OutLog.fromMap(Map<String, dynamic> json) => OutLog(
    logId: json["logId"],
    checkOutDate: DateTime.parse(json["check_out_date"]),
    checkoutId: json["checkoutId"],
    deviceId: json["deviceId"],
    employeeId: json["employeeId"],
  );

  Map<String, dynamic> toMap() => {
    "logId": logId??'',
    "check_out_date": checkOutDate??'',
    "checkoutId": checkoutId,
    "deviceId": deviceId,
    "employeeId": employeeId,
  };
}
