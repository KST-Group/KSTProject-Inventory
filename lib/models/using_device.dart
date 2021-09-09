import 'dart:convert';

UsingDevice usingDeviceFromMap(String str) =>
    UsingDevice.fromMap(json.decode(str));

String usingDeviceToMap(UsingDevice data) => json.encode(data.toMap());

class UsingDevice {
  UsingDevice({
    this.error,
    this.data,
    this.message,
  });

  bool? error;
  List<Using>? data;
  String? message;

  factory UsingDevice.fromMap(Map<String, dynamic> json) => UsingDevice(
        error: json["error"],
        data: List<Using>.from(json["data"].map((x) => Using.fromMap(x))),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "error": error,
        "data": List<dynamic>.from(data!.map((x) => x.toMap())),
        "message": message,
      };
}

class Using {
  Using({
    this.employeeId,
    this.nameEn,
    this.nameLa,
    this.nickname,
    this.email,
    this.checkoutId,
    this.deviceId,
    this.deviceName,
    this.joinDomain,
    this.localId,
    this.typeId,
    this.brandId,
    this.model,
    this.servicetagSn,
    this.cpus,
    this.ram,
    this.hardisk,
  });

  String? employeeId;
  String? nameEn;
  String? nameLa;
  String? nickname;
  String? email;
  String? checkoutId;
  String? deviceId;
  String? deviceName;
  String? joinDomain;
  String? localId;
  int? typeId;
  int? brandId;
  String? model;
  String? servicetagSn;
  String? cpus;
  String? ram;
  String? hardisk;

  factory Using.fromMap(Map<String, dynamic> json) => Using(
        employeeId: json["employeeId"],
        nameEn: json["name_en"],
        nameLa: json["name_la"],
        nickname: json["nickname"],
        email: json["email"],
        checkoutId: json["checkoutId"],
        deviceId: json["deviceId"],
        deviceName: json["device_name"],
        joinDomain: json["joinDomain"],
        localId: json["localId"],
        typeId: json["typeId"],
        brandId: json["brandId"],
        model: json["model"],
        servicetagSn: json["servicetag_sn"],
        cpus: json["cpus"],
        ram: json["ram"],
        hardisk: json["hardisk"],
      );

  Map<String, dynamic> toMap() => {
        "employeeId": employeeId,
        "name_en": nameEn,
        "name_la": nameLa,
        "nickname": nickname,
        "email": email,
        "checkoutId": checkoutId,
        "deviceId": deviceId,
        "device_name": deviceName,
        "joinDomain": joinDomain,
        "localId": localId,
        "typeId": typeId,
        "brandId": brandId,
        "model": model,
        "servicetag_sn": servicetagSn,
        "cpus": cpus,
        "ram": ram,
        "hardisk": hardisk,
      };
}
