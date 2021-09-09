import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kst_inventory/app/middleware/http_value.dart';
import 'package:kst_inventory/models/orders.dart';

class OrderService extends GetxService {
  static OrderService get to => Get.find();

  Future<Orders> getOrderData() async {
    try {
      final response = await http.get(orderDataUrl);
      if (response.statusCode == 200) {
        return Orders.fromMap(jsonDecode(response.body));
      } else {
        throw response.statusCode;
      }
    } on HttpException catch (error) {
      throw error;
    }
  }
}
