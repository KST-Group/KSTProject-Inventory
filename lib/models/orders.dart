// To parse this JSON data, do
//
//     final orders = ordersFromMap(jsonString);

import 'dart:convert';

Orders ordersFromMap(String str) => Orders.fromMap(json.decode(str));

String ordersToMap(Orders data) => json.encode(data.toMap());

class Orders {
  Orders({
    this.error,
    this.data,
    this.message,
  });

  bool? error;
  List<Order>? data;
  String? message;

  factory Orders.fromMap(Map<String, dynamic> json) => Orders(
    error: json["error"],
    data: List<Order>.from(json["data"].map((x) => Order.fromMap(x))),
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "error": error,
    "data": List<dynamic>.from(data!.map((x) => x.toMap())),
    "message": message,
  };
}

class Order {
  Order({
    this.orderId,
    this.orderDate,
    this.provider,
    this.username,
  });

  String? orderId;
  DateTime? orderDate;
  String? provider;
  String? username;

  factory Order.fromMap(Map<String, dynamic> json) => Order(
    orderId: json["orderId"],
    orderDate: DateTime.parse(json["order_date"]),
    provider: json["provider"],
    username: json["username"],
  );

  Map<String, dynamic> toMap() => {
    "orderId": orderId,
    "order_date": orderDate!.toIso8601String(),
    "provider": provider,
    "username": username,
  };
}
