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

  final List<String>columnDevices=[
    'DeviceID',
    'Local ID',
    'Device Name',
    'Bran',
    'Model',
    'Device Type',
    'Service Tag/SN',
    'CPU',
    'Hard Disk',
    'RAM',
  ];

  ///Get employee data list
  RxList<Employee> listEmployees = RxList([]);

  void getEmployeeData() {
    EmployeeServices.to.getDataEmployee().then((value) {
      listEmployees.value = value.data!;
    });
  }
}
