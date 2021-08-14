import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kst_inventory/app/middleware/http_value.dart';
import 'package:kst_inventory/models/brand.dart';
import 'package:kst_inventory/models/device_type.dart';

class DeviceService extends GetxService {
  static DeviceService get to => Get.find();

  ///Device Type
  Future getDeviceTypeData() async {
    try {
      final response = await http.get(typeUrl);
      final jsonStr = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return DeviceType.fromMap(jsonStr);
      } else {
        return response.statusCode;
      }
    } on HttpException catch (error) {
      print(error);
    }
  }

  Future addDeviceType({required String deviceType}) async {
    try {
      final response = await http.post(addTypeUrl, body: {
        'devicetype': deviceType,
      });

      if (response.statusCode == 200) {
        return response.body;
      }
    } on HttpException catch (error) {
      print(error);
    }
  }

  ///Brands
  Future<Brands> getData() async {
    try {
      final response = await http.get(brandUrl);
      if (response.statusCode == 200) {
        return Brands.fromMap(jsonDecode(response.body));
      }
      throw response.statusCode;
    } on HttpException catch (error) {
      print(error);
      throw error;
    }
  }

  Future addBrand({required String brand}) async {
    try {
      final response = await http.post(addBrandUrl, body: {
        'brand': brand,
      });

      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response.statusCode;
      }
    } on HttpException catch (error) {
      print(error);
    }
  }
}
