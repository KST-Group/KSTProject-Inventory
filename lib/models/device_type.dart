

import 'dart:convert';

DeviceType deviceTypeFromMap(String str) => DeviceType.fromMap(json.decode(str));

String deviceTypeToMap(DeviceType data) => json.encode(data.toMap());

class DeviceType {
  DeviceType({
    this.error,
    this.data,
    this.message,
  });

  bool? error;
  List<Types>? data;
  String? message;

  factory DeviceType.fromMap(Map<String, dynamic> json) => DeviceType(
    error: json["error"],
    data: List<Types>.from(json["data"].map((x) => Types.fromMap(x))),
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "error": error,
    "data": List<dynamic>.from(data!.map((x) => x.toMap())),
    "message": message,
  };
}

class Types {
  Types({
    this.typeId,
    this.deviceType,
  });

  int? typeId;
  String? deviceType;

  factory Types.fromMap(Map<String, dynamic> json) => Types(
    typeId: json["typeId"],
    deviceType: json["devicetype"],
  );

  Map<String, dynamic> toMap() => {
    "typeId": typeId,
    "devicetype": deviceType,
  };
}
