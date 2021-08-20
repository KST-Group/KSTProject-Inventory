// To parse this JSON data, do
//
//     final positions = positionsFromMap(jsonString);

import 'dart:convert';

Positions positionsFromMap(String str) => Positions.fromMap(json.decode(str));

String positionsToMap(Positions data) => json.encode(data.toMap());

class Positions {
  Positions({
    this.error,
    this.data,
    this.message,
  });

  bool? error;
  List<Position>? data;
  String? message;

  factory Positions.fromMap(Map<String, dynamic> json) => Positions(
    error: json["error"],
    data: List<Position>.from(json["data"].map((x) => Position.fromMap(x))),
    message: json["message"],
  );

  Map<String, dynamic> toMap() => {
    "error": error,
    "data": List<dynamic>.from(data!.map((x) => x.toMap())),
    "message": message,
  };
}

class Position {
  Position({
    this.positionId,
    this.position,
    this.departmentId,
    this.description,
  });

  dynamic positionId;
  String? position;
  int? departmentId;
  String? description;

  factory Position.fromMap(Map<String, dynamic> json) => Position(
    positionId: json["positionId"],
    position: json["position"],
    departmentId: json["departmentId"],
    description: json["description"],
  );

  Map<String, dynamic> toMap() => {
    "positionId": positionId,
    "position": position,
    "departmentId": departmentId,
    "description": description,
  };
}
