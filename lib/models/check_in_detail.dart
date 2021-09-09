// To parse this JSON data, do
//
//     final checkInDetail = checkInDetailFromMap(jsonString);

import 'dart:convert';

CheckInDetail checkInDetailFromMap(String str) => CheckInDetail.fromMap(json.decode(str));

String checkInDetailToMap(CheckInDetail data) => json.encode(data.toMap());

class CheckInDetail {
  CheckInDetail({
    this.error,
    this.data,
    this.message,
  });

  bool? error;
  List<Details>? data;
  String? message;

  factory CheckInDetail.fromMap(Map<String, dynamic> json) => CheckInDetail(
    error: json["error"],
    data: List<Details>.from(json["data"].map((x) => Details.fromMap(x))),
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "error": error,
    "data": List<dynamic>.from(data!.map((x) => x.toMap())),
    "message": message,
  };
}

class Details {
  Details({
    this.checkinDetailId,
    this.checkinId,
    this.deviceId,
  });

  int? checkinDetailId;
  String? checkinId;
  String? deviceId;

  factory Details.fromMap(Map<String, dynamic> json) => Details(
    checkinDetailId: json["checkinDetailId"],
    checkinId: json["checkinId"],
    deviceId: json["deviceId"],
  );

  Map<String, dynamic> toMap() => {
    "checkinDetailId": checkinDetailId??'',
    "checkinId": checkinId,
    "deviceId": deviceId,
  };
}
