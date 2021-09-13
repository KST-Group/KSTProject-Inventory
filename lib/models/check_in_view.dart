// To parse this JSON data, do
//
//     final checkInViews = checkInViewsFromMap(jsonString);

import 'dart:convert';

CheckInViews checkInViewsFromMap(String str) => CheckInViews.fromMap(json.decode(str));

String checkInViewsToMap(CheckInViews data) => json.encode(data.toMap());

class CheckInViews {
  CheckInViews({
    this.error,
    this.data,
    this.message,
  });

  bool? error;
  List<CheckInViewModel>? data;
  String? message;

  factory CheckInViews.fromMap(Map<String, dynamic> json) => CheckInViews(
    error: json["error"],
    data: List<CheckInViewModel>.from(json["data"].map((x) => CheckInViewModel.fromMap(x))),
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "error": error,
    "data": List<dynamic>.from(data!.map((x) => x.toMap())),
    "message": message,
  };
}

class CheckInViewModel {
  CheckInViewModel({
    this.employeeId,
    this.gender,
    this.nameLa,
    this.nameEn,
    this.nickname,
    this.email,
    this.position,
    this.department,
    this.company,
    this.total,
  });

  String? employeeId;
  String? gender;
  String? nameLa;
  String? nameEn;
  String? nickname;
  String? email;
  String? position;
  String? department;
  String? company;
  int? total;

  factory CheckInViewModel.fromMap(Map<String, dynamic> json) => CheckInViewModel(
    employeeId: json["employeeId"],
    gender: json["gender"],
    nameLa: json["name_la"],
    nameEn: json["name_en"],
    nickname: json["nickname"],
    email: json["email"],
    position: json["position"],
    department: json["department"],
    company: json["company"],
    total: json["total"],
  );

  Map<String, dynamic> toMap() => {
    "employeeId": employeeId,
    "gender": gender,
    "name_la": nameLa,
    "name_en": nameEn,
    "nickname": nickname,
    "email": email,
    "position": position,
    "department": department,
    "company": company,
    "total": total,
  };
}
