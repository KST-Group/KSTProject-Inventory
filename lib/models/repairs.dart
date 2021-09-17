
import 'dart:convert';

Repairs repairsFromMap(String str) => Repairs.fromMap(json.decode(str));

String repairsToMap(Repairs data) => json.encode(data.toMap());

class Repairs {
  Repairs({
    this.error,
    this.data,
    this.message,
  });

  bool? error;
  List<Repair>? data;
  String? message;

  factory Repairs.fromMap(Map<String, dynamic> json) => Repairs(
    error: json["error"],
    data: List<Repair>.from(json["data"].map((x) => Repair.fromMap(x))),
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "error": error,
    "data": List<dynamic>.from(data!.map((x) => x.toMap())),
    "message": message,
  };
}

class Repair {
  Repair({
    this.repairId,
    this.repairDate,
    this.employeeId,
    this.username,
    this.descriptions,
    this.deviceId,
  });

  String? repairId;
  DateTime? repairDate;
  String? employeeId;
  String? username;
  String? descriptions;
  String? deviceId;

  factory Repair.fromMap(Map<String, dynamic> json) => Repair(
    repairId: json["repairId"],
    repairDate: DateTime.parse(json["repair_date"]),
    employeeId: json["employeeId"],
    username: json["username"],
    descriptions: json["descriptions"] == null ? null : json["descriptions"],
    deviceId: json["deviceId"] == null ? null : json["deviceId"],
  );

  Map<String, dynamic> toMap() => {
    "repairId": repairId,
    "repair_date": repairDate!.toIso8601String(),
    "employeeId": employeeId,
    "username": username,
    "descriptions": descriptions == null ? null : descriptions,
    "deviceId": deviceId == null ? null : deviceId,
  };
}
