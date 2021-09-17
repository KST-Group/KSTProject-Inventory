import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kst_inventory/app/middleware/http_value.dart';
import 'package:kst_inventory/models/repaie_device.dart';
import 'package:kst_inventory/models/repairs.dart';

class RepairServices extends GetxService {
  static RepairServices get to => Get.find();

  ///Add
  Future addRepair({required Map<String, dynamic> data}) async {
    try {
      final response = await http.post(addRepairUrl, body: data);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw response.statusCode;
      }
    } on HttpException catch (error) {
      throw error;
    }
  }

  ///Get
  Future<Repairs> getRepairs() async {
    try {
      final response = await http.get(getRepairUrl);
      if (response.statusCode == 200) {
        return Repairs.fromMap(jsonDecode(response.body));
      } else {
        throw response.statusCode;
      }
    } on HttpException catch (error) {
      throw error;
    }
  }

  ///Get Repair dev
  Future<RepairDevices> getRepairsDevice() async {
    try {
      final response = await http.get(getDevRepairLogUrl);
      if (response.statusCode == 200) {
        return RepairDevices.fromMap(jsonDecode(response.body));
      } else {
        throw response.statusCode;
      }
    } on HttpException catch (error) {
      throw error;
    }
  }

  ///Add Log
  Future addRepairLog({required Map<String, dynamic> data}) async {
    try {
      final response = await http.post(adRepairLogUrl, body: data);
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
  Future delRepair({required String deviceId}) async {
    try {
      final response =
          await http.delete(delRepairLogUrl, body: {'deviceId': deviceId});
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw response.statusCode;
      }
    } on HttpException catch (error) {
      throw error;
    }
  }

  ///Add receive log
  Future addReceiveLog({required Map<String, dynamic> data}) async {
    try {
      final response = await http.post(addReceiveLogUrl, body: data);
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
