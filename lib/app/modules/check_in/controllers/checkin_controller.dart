import 'package:get/get.dart';
import 'package:kst_inventory/models/employee.dart';
import 'package:kst_inventory/services/employee_services.dart';

class CheckInController extends GetxController {
  @override
  void onInit() {
    getEmployeeData();
    super.onInit();
  }

  List columnsList = [
    'ID',
    'Gender',
    'Name (Lao)',
    'Name (Eng)',
    'Nickname',
    'Email',
    'Option',
  ];

  ///Get employee data list
  RxList<Employee> listEmployees = RxList([]);

  void getEmployeeData() {
    EmployeeServices.to.getDataEmployee().then((value) {
      listEmployees.value = value.data!;
    });
  }
}
