import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:kst_inventory/app/middleware/http_value.dart';
import 'package:kst_inventory/models/employee.dart';
import 'package:http/http.dart' as http;

class EmployeeServices extends GetxService {
  static EmployeeServices get to => Get.find();

  ///Get data

  Future<Employees> getDataEmployee() async {
    try {
      final response = await http.get(employeeUrl);
      if (response.statusCode == 200) {
        return Employees.fromMap(jsonDecode(response.body));
      } else {
        throw response.statusCode;
      }
    } on HttpException catch (error) {
      throw error;
    }
  }

  ///Add data
  Future addEmployee({required Map<String, dynamic> data}) async {
    try {
      final response = await http.post(addEmployeeUrl, body: data);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return response.statusCode;
      }
    } on HttpException catch (error) {
      throw error;
    }
  }

  ///Delete data
  Future delEmployee({required Map<String, dynamic> data}) async {
    try {
      final response = await http.delete(delEmployeeUrl, body: data);
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
