import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/employees/views/components/add_employee.dart';
import 'package:kst_inventory/models/companys.dart';
import 'package:kst_inventory/models/departments.dart';
import 'package:kst_inventory/models/employee.dart';
import 'package:kst_inventory/models/employee_model.dart';
import 'package:kst_inventory/models/position.dart';
import 'package:kst_inventory/services/company_services.dart';
import 'package:kst_inventory/services/department_services.dart';
import 'package:kst_inventory/services/employee_services.dart';
import 'package:kst_inventory/services/position_service.dart';
import 'package:kst_inventory/utils/dialog.dart';

class EmployeeController extends GetxController {
  ///Global
  var employeeIdAuto = ''.obs;

  @override
  void onInit() {
    getEmployeeData();

    ///Position
    getPosition();
    getDepartmentData();
    getCompany();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  ///Get Auto
  List<int> listEmpId = [];

  getAutoId() {
    DateTime year = DateTime.now();
    int max = 0;
    if (listEmployee.length == 0) {
      max = 1;
    } else {
      for (int i = 0; i < listEmployee.length; i++) {
        listEmpId
            .add(int.parse(listEmployee[i].employeeId.toString().substring(6)));
      }
      max = listEmpId
              .reduce((value, element) => value > element ? value : element) +
          1;
    }
    employeeIdAuto.value =
        'EMP${year.year.toString().substring(2)}${year.month.toString()}${max.toString().padLeft(4, '0')}';
  }

  ///Gender
  String? selectedGender;
  RxList<String> genders = RxList(['Male', 'Female']);

  ///dropdown position
  RxList<Position> listPosition = RxList([]);
  int? selectedPosition;

  void getPosition() {
    PositionServices.to.getPosition().then((value) {
      listPosition.value = value.data!;
    });
  }

  /// dropdown department
  int? selectedDepartment;
  RxList<Department> listDepartment = RxList([]);

  void getDepartmentData() {
    DepartmentServices.to.getData().then((value) {
      listDepartment.value = value.data!;
    });
  }

  ///dropdown Company
  RxList<Company> listCompany = RxList([]);
  int? selectedCompany;

  void getCompany() {
    CompanyService.to.getCompany().then((value) {
      listCompany.value = value.data!;
    });
  }

  ///Get Employee data
  RxList<Employee> listEmployee = RxList([]);

  void getEmployeeData() {
    EmployeeServices.to.getDataEmployee().then((value) {
      listEmployee.value = value.data!;
      getAutoId();
    });
  }

  ///Search
  void onSearch({required String key}) {
    key = key.toString().toLowerCase().trim();
    if (key.isEmpty || key == '') {
      getEmployeeData();
    } else {
      listEmployee.value = listEmployee.where((element) {
        String nameLa = element.nameLa.toString();
        String nameEn = element.nameEn.toString().toLowerCase().trim();
        return nameLa.contains(key) || nameEn.contains(key);
      }).toList();
    }
  }

  ///Add Employee
  TextEditingController nameLaController = TextEditingController();
  TextEditingController nameEnController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  ////////////////////////////////////////////////////////////////////
  String? nameLa;
  String? nameEn;
  String? nickname;
  String? email;

  void addEmployeeData(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 0,
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(
                height: 10,
              ),
              Text(
                'Saving...',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        );
      },
    );

    EmployeeServices.to
        .addEmployee(
            data: EmpModel(
      employeeId: employeeIdAuto.value.toString(),
      nameLa: nameLa,
      nameEn: nameEn,
      nickname: nickname,
      email: email,
      companyId: selectedCompany.toString(),
      departmentId: selectedDepartment.toString(),
      positionId: selectedPosition.toString(),
      gender: selectedGender,
    ).toMap())
        .then((value) {
      getEmployeeData();
      print(value);
      Get.rootDelegate.popRoute();
      Fluttertoast.showToast(msg: 'Success', webPosition: 'center');
    });
  }

  ///Update Employee
  void updateEmployee(
      {required String employeeId, required BuildContext context}) async{
    Dialogs(context: context, message: 'Updating...').progressDialog();

    EmployeeServices.to
        .updateEmployeeService(
            data: EmpModel(
      employeeId: employeeId,
      gender: selectedGender,
      positionId: selectedPosition.toString(),
      departmentId: selectedDepartment.toString(),
      companyId: selectedCompany.toString(),
      nameLa: nameLaController.text,
      nameEn: nameEnController.text,
      nickname: nicknameController.text,
      email: emailController.text,
    ).toMap())
        .then((value) {
      Get.rootDelegate.popRoute().then((value) => Get.rootDelegate.popRoute());
      Fluttertoast.showToast(msg: 'Success', webPosition: 'center');
      getEmployeeData();
      print(value);
    });
  }

  void deleteEmployeeData({required String employeeId}) {
    EmployeeServices.to.delEmployee(data: {
      'employeeId': employeeId,
    }).then((value) {
      getEmployeeData();
      print(value);
    });
  }

  @override
  void dispose() {
    nameLaController.dispose();
    nameEnController.dispose();
    nicknameController.dispose();
    emailController.dispose();
    super.dispose();
  }
}
