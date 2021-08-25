import 'package:get/get.dart';
import 'package:kst_inventory/models/device.dart';
import 'package:kst_inventory/services/device_services.dart';
import 'package:kst_inventory/services/employee_services.dart';

class CheckOutController extends GetxController {
  @override
  void onInit() {
    getEmployeeData();
    getDevice();
    super.onInit();
  }

  ///Get Employee Data
  var listEmployee = [].obs;

  void getEmployeeData() {
    EmployeeServices.to.getDataEmployee().then((value) {
      listEmployee.value = value.data!;
    });
  }

  ///Search
  var employeeValue = ''.obs;

  void onSearchDataEmployee() {
    employeeValue.value = employeeValue.value.toString().toLowerCase().trim();
    listEmployee.value = listEmployee.where((element) {
      String employeeId = element.employeeId.toString().toLowerCase().trim();
      String nameLa = element.nameLa.toString().toLowerCase().trim();
      String nameEn = element.nameEn.toString().toLowerCase().trim();
      String nickname = element.nickname.toString().toLowerCase().trim();
      String email = element.email.toString().toLowerCase().trim();
      return employeeId.contains(employeeValue.value) ||
          nameLa.contains(employeeValue.value) ||
          nameEn.contains(employeeValue.value) ||
          nickname.contains(employeeValue.value) ||
          email.contains(employeeValue.value);
    }).toList();
  }

  ///Get Devices

  RxList<Device> listDevices = RxList([]);

  void getDevice() {
    DeviceService.to.getAllDevice().then((value) {
      listDevices.value = value.data!.where((element) {
        String status = element.statuss.toString();
        return status.contains('empty');
      }).toList();
    });
  }

  ///Selected Device
  RxList<Device> selectedDevice = RxList([]);
  var device = [].obs;

  void onSelected() {
    device.clear();
    selectedDevice.forEach((element) {
      device.add(element.deviceId);
    });
    print(device);
  }
}
