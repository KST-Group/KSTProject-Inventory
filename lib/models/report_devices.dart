// To parse this JSON data, do
//
//     final reportDevices = reportDevicesFromMap(jsonString);

import 'dart:convert';

ReportDevices reportDevicesFromMap(String str) => ReportDevices.fromMap(json.decode(str));

String reportDevicesToMap(ReportDevices data) => json.encode(data.toMap());

class ReportDevices {
  ReportDevices({
    this.error,
    this.data,
    this.message,
  });

  bool? error;
  List<ReportDeviceModel>? data;
  String? message;

  factory ReportDevices.fromMap(Map<String, dynamic> json) => ReportDevices(
    error: json["error"],
    data: List<ReportDeviceModel>.from(json["data"].map((x) => ReportDeviceModel.fromMap(x))),
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "error": error,
    "data": List<dynamic>.from(data!.map((x) => x.toMap())),
    "message": message,
  };
}

class ReportDeviceModel {
  ReportDeviceModel({
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
    this.buyDate,
    this.image,
    this.createDate,
    this.devicetype,
    this.brand,
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
  dynamic? startDate;
  dynamic? expireDate;
  String? remark;
  int? brandId;
  int? typeId;
  dynamic buyDate;
  dynamic image;
  DateTime? createDate;
  String? devicetype;
  String? brand;

  factory ReportDeviceModel.fromMap(Map<String, dynamic> json) => ReportDeviceModel(
    deviceId: json["deviceId"],
    deviceName: json["device_name"],
    statuss: json["statuss"],
    comments: json["comments"],
    joinDomain: json["joinDomain"],
    model: json["model"],
    servicetagSn: json["servicetag_sn"],
    localId: json["localId"],
    computername: json["computername"],
    cpus: json["cpus"],
    ram: json["ram"],
    hardisk: json["hardisk"],
    provider: json["provider"],
    price: json["price"],
    warranty: json["warranty"],
    startDate: json["startDate"],
    expireDate: json["expireDate"],
    remark: json["remark"],
    brandId: json["brandId"],
    typeId: json["typeId"],
    buyDate: json["buy_date"],
    image: json["image"],
    createDate: DateTime.parse(json["create_date"]),
    devicetype: json["devicetype"],
    brand: json["brand"],
  );

  Map<String, dynamic> toMap() => {
    "deviceId": deviceId,
    "device_name": deviceName,
    "statuss": statuss,
    "comments": comments,
    "joinDomain": joinDomain,
    "model": model,
    "servicetag_sn": servicetagSn,
    "localId": localId,
    "computername": computername,
    "cpus": cpus,
    "ram": ram,
    "hardisk": hardisk,
    "provider": provider,
    "price": price,
    "warranty": warranty,
    "startDate": startDate,
    "expireDate": expireDate,
    "remark": remark,
    "brandId": brandId,
    "typeId": typeId,
    "buy_date": buyDate,
    "image": image,
    "create_date": createDate!.toIso8601String(),
    "devicetype": devicetype,
    "brand": brand,
  };
}
