import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:kst_inventory/app/middleware/http_value.dart';
import 'package:kst_inventory/models/position.dart';

class PositionServices extends GetxService {
  static PositionServices get to => Get.find();

  ///Get dat
  Future<Positions> getPosition() async {
    try {
      final response = await http.get(positionUrl);
      if (response.statusCode == 200) {
        return Positions.fromMap(jsonDecode(response.body));
      } else {
        throw response.statusCode;
      }
    } on HttpException catch (error) {
      throw error;
    }
  }

  ///Add data
  Future addPositionData({required Map<String, dynamic> data}) async {
    try {
      final response = await http.post(addPositionUrl, body: data);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw response.statusCode;
      }
    } on HttpException catch (error) {
      throw error;
    }
  }

  ///Delete
  Future deletePosition({required String positionId}) async {
    try {
      final response = await http.delete(deletePositionUrl, body: {
        'positionId': positionId,
      });
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw response.statusCode;
      }
    } on HttpException catch (error) {
      throw error;
    }
  }
}
