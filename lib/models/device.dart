// To parse this JSON data, do
//
//     final devices = devicesFromMap(jsonString);

import 'dart:convert';

Devices devicesFromMap(String str) => Devices.fromMap(json.decode(str));

String devicesToMap(Devices data) => json.encode(data.toMap());

class Devices {
  Devices({
    this.error,
    this.data,
    this.message,
  });

  bool? error;
  List<Device>? data;
  String? message;

  factory Devices.fromMap(Map<String, dynamic> json) => Devices(
    error: json["error"],
    data: List<Device>.from(json["data"].map((x) => Device.fromMap(x))),
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "error": error,
    "data": List<dynamic>.from(data!.map((x) => x.toMap())),
    "message": message,
  };
}

class Device {
  Device({
    this.deviceId,
    this.localId,
    this.deviceName,
    this.computername,
    this.comments,
    this.joinDomain,
    this.model,
    this.servicetagSn,
    this.provider,
    this.deviceType,
    this.brand,
    this.cpus,
    this.ram,
    this.hardisk,
    this.price,
    this.expireDate,
    this.remark,
    this.statuss,
  });

  String? deviceId;
  String? localId;
  String? deviceName;
  String? computername;
  String? comments;
  String? joinDomain;
  String? model;
  String? servicetagSn;
  String? provider;
  String? deviceType;
  String? brand;
  String? cpus;
  String? ram;
  String? hardisk;
  String? price;
  String? expireDate;
  String? remark;
  String? statuss;

  factory Device.fromMap(Map<String, dynamic> json) => Device(
    deviceId: json["deviceId"],
    localId: json["localId"],
    deviceName: json["device_name"],
    computername: json["computername"],
    comments: json["comments"],
    joinDomain: json["joinDomain"],
    model: json["model"],
    servicetagSn: json["servicetag_sn"],
    provider: json["provider"],
    deviceType: json["deviceType"],
    brand: json["brand"],
    cpus: json["cpus"],
    ram: json["ram"],
    hardisk: json["hardisk"],
    price: json["price"],
    expireDate: json["expireDate"],
    remark: json["remark"],
    statuss: json["statuss"],
  );

  Map<String, dynamic> toMap() => {
    "deviceId": deviceId,
    "localId": localId,
    "device_name": deviceName,
    "computername": computername,
    "comments": comments,
    "joinDomain": joinDomain,
    "model": model,
    "servicetag_sn": servicetagSn,
    "provider": provider,
    "deviceType": deviceType,
    "brand": brand,
    "cpus": cpus,
    "ram": ram,
    "hardisk": hardisk,
    "price": price,
    "expireDate": expireDate,
    "remark": remark,
    "statuss": statuss,
  };
}

