import 'dart:convert';

Checkouts checkoutsFromMap(String str) => Checkouts.fromMap(json.decode(str));

String checkoutsToMap(Checkouts data) => json.encode(data.toMap());

class Checkouts {
  Checkouts({
    this.error,
    this.data,
    this.message,
  });

  bool? error;
  List<Checkout>? data;
  String? message;

  factory Checkouts.fromMap(Map<String, dynamic> json) => Checkouts(
    error: json["error"],
    data: List<Checkout>.from(json["data"].map((x) => Checkout.fromMap(x))),
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "error": error,
    "data": List<dynamic>.from(data!.map((x) => x.toMap())),
    "message": message,
  };
}

class Checkout {
  Checkout({
    this.checkoutId,
    this.checkOutDate,
    this.username,
    this.employeeId,
  });

  String? checkoutId;
  DateTime? checkOutDate;
  String? username;
  String? employeeId;

  factory Checkout.fromMap(Map<String, dynamic> json) => Checkout(
    checkoutId: json["checkoutId"],
    checkOutDate: DateTime.parse(json["checkOutDate"]),
    username: json["username"],
    employeeId: json["employeeId"],
  );

  Map<String, dynamic> toMap() => {
    "checkoutId": checkoutId,
    "checkOutDate": checkOutDate!.toIso8601String(),
    "username": username,
    "employeeId": employeeId,
  };
}
