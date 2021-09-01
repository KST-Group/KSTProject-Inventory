import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kst_inventory/app/middleware/http_value.dart';
import 'package:kst_inventory/models/brand.dart';
import 'package:kst_inventory/models/device.dart';
import 'package:kst_inventory/models/device_type.dart';

class DeviceService extends GetxService {
  static DeviceService get to => Get.find();

  ///Device Type
  Future getDeviceTypeData() async {
    try {
      final response = await http.get(typeUrl);
      final jsonStr = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return DeviceTypes.fromMap(jsonStr);
      } else {
        return response.statusCode;
      }
    } on HttpException catch (error) {
      print(error);
    }
  }

  Future addDeviceType({
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await http.post(
        addTypeUrl,
        body: data,
      );
      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw response.statusCode;
      }
    } on HttpException catch (error) {
      throw error;
    }
  }

  ///Brands
  Future<Brands> getDataBrand() async {
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

  ///Device
  ///Get all Devices
  Future<Devices> getAllDevice() async {
    try {
      final response = await http.get(deviceUrl);
      if (response.statusCode == 200) {
        return Devices.fromMap(jsonDecode(response.body));
      }
      throw response.statusCode;
    } on HttpException catch (error) {
      throw error;
    }
  }

  ///Add Device Data
  Future addDevice({required Map<String, dynamic> data}) async {
    try {
      final response = await http.post(addDeviceUrl, body: data);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw response.statusCode;
      }
    } on HttpException catch (error) {
      throw error;
    }
  }

  Future<Devices> getDeviceById({required String deviceId}) async {
    try {
      final response = await http.get(getDeviceByIdeUrl(deviceId));
      if (response.statusCode == 200) {
        return Devices.fromMap(jsonDecode(response.body));
      } else {
        throw response.statusCode;
      }
    } on HttpException catch (error) {
      throw error;
    }
  }

  ///Delete device
  Future deleteDevice({required String deviceId}) async {
    try {
      final response =
          await http.delete(deleteByIdeUrl, body: {'deviceId': deviceId});
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
