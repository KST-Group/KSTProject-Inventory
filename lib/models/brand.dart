import 'dart:convert';

Brands brandsFromMap(String str) => Brands.fromMap(json.decode(str));

String brandsToMap(Brands data) => json.encode(data.toMap());

class Brands {
  Brands({
    this.error,
    this.data,
    this.message,
  });

  bool? error;
  List<Brand>? data;
  String? message;

  factory Brands.fromMap(Map<String, dynamic> json) => Brands(
    error: json["error"],
    data: List<Brand>.from(json["data"].map((x) => Brand.fromMap(x))),
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "error": error,
    "data": List<dynamic>.from(data!.map((x) => x.toMap())),
    "message": message,
  };
}

class Brand {
  Brand({
    this.brandId,
    this.brand,
  });

  int? brandId;
  String? brand;

  factory Brand.fromMap(Map<String, dynamic> json) => Brand(
    brandId: json["brandId"],
    brand: json["brand"],
  );

  Map<String, dynamic> toMap() => {
    "brandId": brandId,
    "brand": brand,
  };
}
