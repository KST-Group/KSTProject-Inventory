import 'dart:math';

import 'package:get/get.dart';
import 'package:kst_inventory/models/employee.dart';
import 'package:kst_inventory/services/company_services.dart';
import 'package:kst_inventory/services/department_services.dart';
import 'package:kst_inventory/services/employee_services.dart';
import 'package:kst_inventory/services/position_service.dart';

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

  ///Filter dropdown position
  var listPosition = [].obs;
  var dropDownPosition = ''.obs;

  void getPosition() {
    PositionServices.to.getPosition().then((value) {
      listPosition.value = value.data!;
      dropDownPosition.value = listPosition[0].position.toString();
      selectedPosition.value = listPosition[0].positionId.toString();
      print(selectedPosition);
    });
  }

  void onChangePosition(String value) {
    dropDownPosition.value = value;

    listEmployee.value = listEmployee.where((data) {
      String position = data.position.toString();
      return position.contains(dropDownPosition.value);
    }).toList();
  }

  ///Filter dropdown department
  var dropDownDepartment = ''.obs;
  var listDepartment = [].obs;

  void getDepartmentData() {
    DepartmentServices.to.getData().then((value) {
      listDepartment.value = value.data!;
      dropDownDepartment.value = listDepartment[0].departmentId.toString();
      selectedDepartment.value = listDepartment[0].departmentId.toString();
    });
  }

  void onChangeDepartment(String value) {
    dropDownDepartment.value = value;
  }

  ///Filter dropdown Company
  var dropDownCompany = ''.obs;
  var listCompany = [].obs;

  void getCompany() {
    CompanyService.to.getCompany().then((value) {
      listCompany.value = value.data!;
      dropDownCompany.value = listCompany[0].companyId.toString();
      selectedCompany.value = listCompany[0].companyId.toString();
    });
  }

  void onChangeCompany(String value) {
    dropDownCompany.value = value;
  }

  ///Get Employee data
  var listEmployee = [].obs;

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

  ////////////////////////////////////////////////////////////////////
  ///Select insert
  var selectedCompany = ''.obs;

  void onSelectCompany(String value) {
    selectedCompany.value = value;
    print(selectedCompany.value);
  }

  ///Department
  var selectedDepartment = ''.obs;

  void onSelectedDepartment(String value) {
    selectedDepartment.value = value;
  }

  ///Position
  var selectedPosition = ''.obs;

  void onSelectedPosition(String value) {
    selectedPosition.value = value;
  }

  ///Add Employee Data
  var gender = 'Male'.obs;
  var nameEn = ''.obs;
  var nameLa = ''.obs;
  var nickname = ''.obs;
  var email = ''.obs;

  void addEmployeeData() {
    EmployeeServices.to.addEmployee(data: {
      'employeeId': employeeIdAuto.value,
      'companyId': selectedCompany.value,
      'departmentId': selectedDepartment.value,
      'positionId': selectedPosition.value,
      'gender': gender.value,
      'name_en': nameEn.value,
      'name_la': nameLa.value,
      'nickname': nickname.value,
      'email': email.value,
    }).then((value) {
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
}
