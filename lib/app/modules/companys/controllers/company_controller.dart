import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/models/companys.dart';
import 'package:kst_inventory/services/company_services.dart';
import 'package:kst_inventory/services/employee_services.dart';

class CompanyController extends GetxController {
  @override
  void onInit() {
    getCompany();
    getEmployeeData();
    super.onInit();
  }

  ///Get Company Data
  var listCompany = [].obs;

  Future getCompany() async {
    CompanyService.to.getCompany().then((value) {
      listCompany.value = value.data!;
    });
  }

  ///Delete Company
  Future deleteCompany({required String companyId}) async {
    CompanyService.to.deleteCompany(companyId: companyId).then((value) {
      getCompany();
      print(value);
    });
  }

  ///Add a company

  var company = ''.obs;
  var description = ''.obs;
  var address = ''.obs;
  var tel = ''.obs;

  Future addCompany() async {
    CompanyService.to.addCompany(data: {
      'company': company.value,
      'description': description.value,
      'address': address.value,
      'tel': tel.value,
    }).then((value) {
      getCompany();
      print(value);
    });
  }

  ///Get Employee
  var listEmployee = [].obs;
  void getEmployeeData() {
    EmployeeServices.to.getDataEmployee().then((value) {
      listEmployee.value = value.data!;
    });
  }

  // void setEmployeeData({required String value}){
  //   listEmployee.value=listEmployee.where((element) {
  //
  //   }).toList();
  //
  // }
}
