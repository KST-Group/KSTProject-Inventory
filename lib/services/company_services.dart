import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kst_inventory/app/middleware/http_value.dart';
import 'package:kst_inventory/models/companys.dart';
import 'package:kst_inventory/models/departments.dart';

class CompanyService extends GetxService {
  static CompanyService get to => Get.find();

  ///Company
  Future<Companys> getCompany() async {
    try {
      final response = await http.get(companyUrl);
      if (response.statusCode == 200) {
        return Companys.fromMap(jsonDecode(response.body));
      } else {
        throw response.statusCode;
      }
    } on HttpException catch (error) {
      throw error;
    }
  }

  ///Delete company
  Future deleteCompany({required String companyId}) async {
    try {
      final response =
          await http.delete(deleteCompanyUrl, body: {'companyId': companyId});
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print(response.statusCode);
      }
    } on HttpException catch (error) {
      print(error);
    }
  }

  ///Add Company
  Future addCompany({required Map<String, dynamic>? data}) async {
    try {
      final response = await http.post(addCompanyUrl, body: data);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print(response.statusCode);
      }
    } on HttpException catch (error) {
      print(error);
    }
  }

  ///Get Department
  Future<Departments> getDepartment({required String companyId}) async {
    try {
      final response = await http.get(departByCompany(companyId));
      if (response.statusCode == 200) {
        return Departments.fromMap(jsonDecode(response.body));
      } else {
        throw response.statusCode;
      }
    } on HttpException catch (error) {
      throw error;
    }
  }
}
