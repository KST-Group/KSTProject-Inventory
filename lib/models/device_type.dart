import 'dart:convert';

DeviceTypes deviceTypesFromMap(String str) =>
    DeviceTypes.fromMap(json.decode(str));

String deviceTypesToMap(DeviceTypes data) => json.encode(data.toMap());

class DeviceTypes {
  DeviceTypes({
    this.error,
    this.data,
    this.message,
  });

  bool? error;
  List<Types>? data;
  String? message;

  factory DeviceTypes.fromMap(Map<String, dynamic> json) => DeviceTypes(
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
    this.devicetype,
  });

  int? typeId;
  String? devicetype;

  factory Types.fromMap(Map<String, dynamic> json) => Types(
        typeId: json["typeId"],
        devicetype: json["devicetype"],
      );

  Map<String, dynamic> toMap() => {
        "typeId": typeId,
        "devicetype": devicetype,
      };
}
