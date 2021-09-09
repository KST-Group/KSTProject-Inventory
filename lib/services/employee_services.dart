import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:kst_inventory/app/middleware/http_value.dart';
import 'package:kst_inventory/models/employee.dart';
import 'package:http/http.dart' as http;
import 'package:kst_inventory/models/employee_device.dart';
import 'package:kst_inventory/models/using_device_employee.dart';

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

  ///Get dat with device
  Future<EmployeeDevice> getDataDev() async {
    try {
      final response = await http.get(delEmployeeDeviceUrl);
      if (response.statusCode == 200) {
        return EmployeeDevice.fromMap(jsonDecode(response.body));
      } else {
        throw response.statusCode;
      }
    } on HttpException catch (error) {
      throw error;
    }
  }

  ///Get Data with using device
  Future<UsingDeviceEmployee> getDeviceUsingDataEmployee() async {
    try {
      final response = await http.get(employeeUsingDeviceUrl);
      if (response.statusCode == 200) {
        return UsingDeviceEmployee.fromMap(jsonDecode(response.body));
      } else {
        throw response.statusCode;
      }
    } on HttpException catch (error) {
      throw error;
    }
  }
}
