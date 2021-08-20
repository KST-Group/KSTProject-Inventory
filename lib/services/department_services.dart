import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:kst_inventory/app/middleware/http_value.dart';
import 'package:kst_inventory/models/departments.dart';

class DepartmentServices extends GetxService {
  static DepartmentServices get to => Get.find();

  ///Get Data
  Future<Departments> getData() async {
    try {
      final response = await http.get(getDepartmentUrl);
      if (response.statusCode == 200) {
        return Departments.fromMap(jsonDecode(response.body));
      } else {
        throw response.statusCode;
      }
    } on HttpException catch (error) {
      throw error;
    }
  }

  ///Delete
  Future deleteDepartment({required String departmentId}) async {
    try {
      final response = await http.delete(deleteDepartmentUrl, body: {
        'departmentId': departmentId,
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

  ///Add Data
  Future addData({required Map<String, dynamic> data}) async {
    try {
      final response = await http.post(addDepartmentUrl, body: data);
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
