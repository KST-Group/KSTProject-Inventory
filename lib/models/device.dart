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
    this.deviceName,
    this.statuss,
    this.comments,
    this.joinDomain,
    this.model,
    this.servicetagSn,
    this.localId,
    this.computername,
    this.cpus,
    this.ram,
    this.hardisk,
    this.provider,
    this.price,
    this.warranty,
    this.startDate,
    this.expireDate,
    this.remark,
    this.brandId,
    this.typeId,
  });

  String? deviceId;
  String? deviceName;
  String? statuss;
  String? comments;
  String? joinDomain;
  String? model;
  String? servicetagSn;
  String? localId;
  String? computername;
  String? cpus;
  String? ram;
  String? hardisk;
  String? provider;
  String? price;
  String? warranty;
  String? startDate;
  String? expireDate;
  String? remark;
  int? brandId;
  int? typeId;

  factory Device.fromMap(Map<String, dynamic> json) => Device(
    deviceId: json["deviceId"],
    deviceName: json["device_name"],
    statuss: json["statuss"] == null ? null : json["statuss"],
    comments: json["comments"] == null ? null : json["comments"],
    joinDomain: json["joinDomain"] == null ? null : json["joinDomain"],
    model: json["model"] == null ? null : json["model"],
    servicetagSn: json["servicetag_sn"] == null ? null : json["servicetag_sn"],
    localId: json["localId"] == null ? null : json["localId"],
    computername: json["computername"] == null ? null : json["computername"],
    cpus: json["cpus"] == null ? null : json["cpus"],
    ram: json["ram"] == null ? null : json["ram"],
    hardisk: json["hardisk"] == null ? null : json["hardisk"],
    provider: json["provider"] == null ? null : json["provider"],
    price: json["price"] == null ? null : json["price"],
    warranty: json["warranty"] == null ? null : json["warranty"],
    startDate: json["startDate"] == null ? null : json["startDate"],
    expireDate: json["expireDate"] == null ? null : json["expireDate"],
    remark: json["remark"] == null ? null : json["remark"],
    brandId: json["brandId"] == null ? null : json["brandId"],
    typeId: json["typeId"] == null ? null : json["typeId"],
  );

  Map<String, dynamic> toMap() => {
    "deviceId": deviceId,
    "device_name": deviceName,
    "statuss": statuss == null ? null : statuss,
    "comments": comments == null ? null : comments,
    "joinDomain": joinDomain == null ? null : joinDomain,
    "model": model == null ? null : model,
    "servicetag_sn": servicetagSn == null ? null : servicetagSn,
    "localId": localId == null ? null : localId,
    "computername": computername == null ? null : computername,
    "cpus": cpus == null ? null : cpus,
    "ram": ram == null ? null : ram,
    "hardisk": hardisk == null ? null : hardisk,
    "provider": provider == null ? null : provider,
    "price": price == null ? null : price,
    "warranty": warranty == null ? null : warranty,
    "startDate": startDate == null ? null : startDate,
    "expireDate": expireDate == null ? null : expireDate,
    "remark": remark == null ? null : remark,
    "brandId": brandId == null ? null : brandId,
    "typeId": typeId == null ? null : typeId,
  };
}
