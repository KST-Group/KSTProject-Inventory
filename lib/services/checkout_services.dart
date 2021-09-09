import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kst_inventory/app/middleware/http_value.dart';
import 'package:kst_inventory/models/checkout.dart';
import 'package:kst_inventory/models/using_device.dart';

class CheckoutServices extends GetxService {
  static CheckoutServices get to => Get.find();

  ///GetData Checkout Only
  Future<Checkouts> getCheckoutOnly() async {
    try {
      final response = await http.get(checkOutDataUrl);
      if (response.statusCode == 200) {
        return Checkouts.fromMap(jsonDecode(response.body));
      } else {
        throw response.statusCode;
      }
    } on HttpException catch (error) {
      throw error;
    }
  }

  Future createCheckout({required Map<String, dynamic> data}) async {
    try {
      final response = await http.post(checkoutDeviceUrl, body: data);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw response.statusCode;
      }
    } on HttpException catch (error) {
      throw error;
    }
  }

  Future createDetail({required Map<String, dynamic> data}) async {
    try {
      final response = await http.post(checkoutDetailUrl, body: data);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw response.statusCode;
      }
    } on HttpException catch (error) {
      throw error;
    }
  }

  Future updatesStatus({required Map<String, dynamic> data}) async {
    try {
      final response = await http.put(updateStatusUrl, body: data);
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
