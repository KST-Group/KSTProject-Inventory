// To parse this JSON data, do
//
//     final repairDevices = repairDevicesFromMap(jsonString);

import 'dart:convert';

RepairDevices repairDevicesFromMap(String str) =>
    RepairDevices.fromMap(json.decode(str));

String repairDevicesToMap(RepairDevices data) => json.encode(data.toMap());

class RepairDevices {
  RepairDevices({
    this.error,
    this.data,
    this.message,
  });

  bool? error;
  List<RepairDevice>? data;
  String? message;

  factory RepairDevices.fromMap(Map<String, dynamic> json) => RepairDevices(
        error: json["error"],
        data: List<RepairDevice>.from(
            json["data"].map((x) => RepairDevice.fromMap(x))),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "error": error,
        "data": List<dynamic>.from(data!.map((x) => x.toMap())),
        "message": message,
      };
}

class RepairDevice {
  RepairDevice({
    this.repairId,
    this.repairDate,
    this.employeeId,
    this.username,
    this.descriptions,
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
    this.devicetype,
    this.brand,
  });

  String? repairId;
  DateTime? repairDate;
  String? employeeId;
  String? username;
  String? descriptions;
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
  dynamic startDate;
  dynamic expireDate;
  String? remark;
  int? brandId;
  int? typeId;
  dynamic buyDate;
  String? devicetype;
  String? brand;

  factory RepairDevice.fromMap(Map<String, dynamic> json) => RepairDevice(
        repairId: json["repairId"],
        repairDate: DateTime.parse(json["repair_date"]),
        employeeId: json["employeeId"],
        username: json["username"],
        descriptions: json["descriptions"],
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
        devicetype: json["devicetype"],
        brand: json["brand"],
      );

  Map<String, dynamic> toMap() => {
        "repairId": repairId,
        "repair_date": repairDate!.toIso8601String(),
        "employeeId": employeeId,
        "username": username,
        "descriptions": descriptions,
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
        "devicetype": devicetype,
        "brand": brand,
      };
}
