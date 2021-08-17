// To parse this JSON data, do
//
//     final companys = companysFromMap(jsonString);

import 'dart:convert';

Companys companysFromMap(String str) => Companys.fromMap(json.decode(str));

String companysToMap(Companys data) => json.encode(data.toMap());

class Companys {
  Companys({
    this.error,
    this.data,
    this.message,
  });

  bool? error;
  List<Company>? data;
  String? message;

  factory Companys.fromMap(Map<String, dynamic> json) => Companys(
        error: json["error"],
        data: List<Company>.from(json["data"].map((x) => Company.fromMap(x))),
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "error": error,
        "data": List<dynamic>.from(data!.map((x) => x.toMap())),
        "message": message,
      };
}

class Company {
  Company(
      {this.companyId, this.company, this.description, this.address, this.tel});

  int? companyId;
  String? company;
  String? description;
  String? address;
  String? tel;

  factory Company.fromMap(Map<String, dynamic> json) => Company(
        companyId: json["companyId"],
        company: json["company"],
        description: json["description"],
        address: json["address"],
        tel: json["tel"],
      );

  Map<String, dynamic> toMap() => {
        "companyId": companyId,
        "company": company,
        "description": description,
        "address": address,
        "tel": tel,
      };
}
