// To parse this JSON data, do
//
//     final repairsLogs = repairsLogsFromMap(jsonString);

import 'dart:convert';

RepairsLogs repairsLogsFromMap(String str) => RepairsLogs.fromMap(json.decode(str));

String repairsLogsToMap(RepairsLogs data) => json.encode(data.toMap());

class RepairsLogs {
  RepairsLogs({
    this.error,
    this.data,
    this.message,
  });

  bool? error;
  List<RepairLog>? data;
  String? message;

  factory RepairsLogs.fromMap(Map<String, dynamic> json) => RepairsLogs(
    error: json["error"],
    data: List<RepairLog>.from(json["data"].map((x) => RepairLog.fromMap(x))),
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "error": error,
    "data": List<dynamic>.from(data!.map((x) => x.toMap())),
    "message": message,
  };
}

class RepairLog {
  RepairLog({
    this.logId,
    this.logDate,
    this.repairId,
    this.deviceId,
    this.employeeId,
    this.descriptions,
  });

  String? logId;
  DateTime? logDate;
  String? repairId;
  String? deviceId;
  String? employeeId;
  String? descriptions;

  factory RepairLog.fromMap(Map<String, dynamic> json) => RepairLog(
    logId: json["logId"],
    logDate: DateTime.parse(json["log_date"]),
    repairId: json["repairId"],
    deviceId: json["deviceId"],
    employeeId: json["employeeId"],
    descriptions: json["descriptions"],
  );

  Map<String, dynamic> toMap() => {
    "logId": logId??'',
    "log_date": logDate!.toIso8601String(),
    "repairId": repairId,
    "deviceId": deviceId,
    "employeeId": employeeId,
    "descriptions": descriptions,
  };
}
