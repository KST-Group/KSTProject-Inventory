// To parse this JSON data, do
//
//     final receiveLogs = receiveLogsFromMap(jsonString);

import 'dart:convert';

ReceiveLogs receiveLogsFromMap(String str) => ReceiveLogs.fromMap(json.decode(str));

String receiveLogsToMap(ReceiveLogs data) => json.encode(data.toMap());

class ReceiveLogs {
  ReceiveLogs({
    this.error,
    this.data,
    this.message,
  });

  bool? error;
  List<ReceiveLog>? data;
  String? message;

  factory ReceiveLogs.fromMap(Map<String, dynamic> json) => ReceiveLogs(
    error: json["error"],
    data: List<ReceiveLog>.from(json["data"].map((x) => ReceiveLog.fromMap(x))),
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "error": error,
    "data": List<dynamic>.from(data!.map((x) => x.toMap())),
    "message": message,
  };
}

class ReceiveLog {
  ReceiveLog({
    this.logId,
    this.repairId,
    this.receiveDate,
    this.deviceId,
    this.employeeId,
    this.descriptions,
  });

  int? logId;
  String? repairId;
  DateTime? receiveDate;
  String? deviceId;
  String? employeeId;
  String? descriptions;

  factory ReceiveLog.fromMap(Map<String, dynamic> json) => ReceiveLog(
    logId: json["logId"],
    repairId: json["repairId"],
    receiveDate: DateTime.parse(json["receive_date"]),
    deviceId: json["deviceId"],
    employeeId: json["employeeId"],
    descriptions: json["descriptions"],
  );

  Map<String, dynamic> toMap() => {
    "logId": logId??'',
    "repairId": repairId??'',
    "receive_date": receiveDate??'',
    "deviceId": deviceId??'',
    "employeeId": employeeId??'',
    "descriptions": descriptions??'',
  };
}
