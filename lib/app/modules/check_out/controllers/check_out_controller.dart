import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/models/check_out_log.dart';
import 'package:kst_inventory/models/checkout.dart';
import 'package:kst_inventory/models/device.dart';
import 'package:kst_inventory/models/employee.dart';
import 'package:kst_inventory/models/employee_device.dart';
import 'package:kst_inventory/models/using_device.dart';
import 'package:kst_inventory/models/using_device_employee.dart';
import 'package:kst_inventory/services/checkout_services.dart';
import 'package:kst_inventory/services/device_services.dart';
import 'package:kst_inventory/services/employee_services.dart';

class CheckOutController extends GetxController {
  ///Global
  RxBool loading = RxBool(false);

  final List<String> columnsDevice = [
    'No',
    '',
    'ID',
    '',
    'Device Name',
    '',
    'Device Type',
    '',
    'Comment',
    '',
    'Model',
    '',
    'brand',
    '',
    'CPU',
    '',
    'RAM',
    '',
    'Hard Disk',
  ];

  final List<String> columnCheckOut = [
    'No',
    '',
    'Employee ID',
    '',
    'Gender',
    '',
    'Name (Lao)',
    '',
    'Name (Eng)',
    '',
    'Nickname',
    '',
    'Email',
    '',
    'Position',
    '',
    'Department',
    '',
    'Company',
    '',
    'Total',
  ];

  @override
  void onInit() {
    getEmployeeData();
    getDevice();
    getDataCheckoutOnly();
    getUseDevice();
    super.onInit();
  }

  ///Get Auto ID
  List<int> listCheckId = [];
  RxString checkOutAutoId = RxString('');

  void getAutoId() {
    DateTime year = DateTime.now();
    int max = 0;

    if (lisCheckout.length == 0) {
      max = 1;
    } else {
      for (int i = 0; i < lisCheckout.length; i++) {
        listCheckId
            .add(int.parse(lisCheckout[i].checkoutId.toString().substring(5)));
      }
      max = listCheckId
              .reduce((value, element) => value > element ? value : element) +
          1;
    }
    checkOutAutoId.value =
        'CH${year.year.toString().substring(2)}${year.month.toString()}${max.toString().padLeft(4, '0')}';
  }

  ///Get Checkout Data only
  RxList<Checkout> lisCheckout = RxList([]);

  void getDataCheckoutOnly() {
    CheckoutServices.to.getCheckoutOnly().then((value) {
      lisCheckout.value = value.data!;
      getAutoId();
    });
  }

  Employee employeeData = Employee();

  // ///Get Employee Data
  // RxList<Employee> listEmployee = RxList([]);
  //
  // void getEmployeeData() async {
  //   loading.value = true;
  //   await Future.delayed(Duration(milliseconds: 3));
  //   EmployeeServices.to.getDataEmployee().then((value) {
  //     listEmployee.value = value.data!;
  //
  //     loading.value = false;
  //   });
  // }
  RxList<EmployeeDev> listEmployee = RxList([]);

  void getEmployeeData() {
    EmployeeServices.to.getDataDev().then((value) {
      listEmployee.value = value.data!;
    });
  }

  ///Search
  var employeeValueController = TextEditingController();
  var employeeValue = ''.obs;

  void onSearchDataEmployee() {
    loading.value = true;
    if (employeeValueController.text.isEmpty) {
      getEmployeeData();
    } else {
      String emp = employeeValueController.text.toLowerCase().trim();
      listEmployee.value = listEmployee.where((element) {
        String employeeId = element.employeeId.toString().toLowerCase().trim();
        String nameLa = element.nameLa.toString().toLowerCase().trim();
        String nameEn = element.nameEn.toString().toLowerCase().trim();
        String nickname = element.nickname.toString().toLowerCase().trim();
        String email = element.email.toString().toLowerCase().trim();
        return employeeId.contains(emp) ||
            nameLa.contains(emp) ||
            nameEn.contains(emp) ||
            nickname.contains(emp) ||
            email.contains(emp);
      }).toList();
      loading.value = false;
    }
  }

  ///Get Devices

  RxList<Device> listDevices = RxList([]);

  void getDevice() {
    DeviceService.to.getAllDevice().then((value) {
      listDevices.value = value.data!.where((element) {
        String status = element.statuss.toString();
        return status.contains('In Stock');
      }).toList();
    });
  }

  ///Search Device Checkout
  RxList<Device> listSearchDevice = RxList([]);
  TextEditingController searchTextController = TextEditingController();
  var searchText = ''.obs;

  void onSearchDeviceCheckout() {
    String value = searchText.value.toString().toLowerCase().trim();
    listSearchDevice.value = listDevices.where((device) {
      String deviceId = device.deviceId.toString().toLowerCase().trim();
      String localId = device.localId.toString().toLowerCase().trim();
      String deviceName = device.deviceName.toString().toLowerCase().trim();
      String deviceType = device.deviceType.toString().toLowerCase().trim();
      String brand = device.brand.toString().toLowerCase().trim();
      String model = device.model.toString().toLowerCase().trim();
      return deviceId.contains(value) ||
          localId.contains(value) ||
          deviceName.contains(value) ||
          deviceType.contains(value) ||
          brand.contains(value) ||
          model.contains(value);
    }).toList();
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

  Future checkOutDevice(BuildContext context) async {
    if (device.length == 0) {
      print('Please select at lease 1 device ');
    } else {
      print(device);
      CheckoutServices.to.createCheckout(data: {
        'checkoutId': checkOutAutoId.value,
        'username': 'admin',
        'employeeId': employeeData.employeeId,
      }).then((value) {
        print('CheckOut:$value}');
        for (int i = 0; i < device.length; i++) {
          CheckoutServices.to.createDetail(data: {
            'checkoutId': checkOutAutoId.value,
            'deviceId': device[i].toString(),
          }).then((value) {
            print('CheckOutDetail:$value}');
          });
          ///Add Log
          CheckoutServices.to.addCheckoutLog(data: OutLog(
            checkoutId: checkOutAutoId.value,
            employeeId: employeeData.employeeId,
            deviceId: device[i].toString(),
          ).toMap()).then((value) {
            print('Add Log Success');
          });
          CheckoutServices.to.updatesStatus(data: {
            'deviceId': device[i].toString(),
          }).then((value) {
            device.clear();
            selectedDevice.clear();
            Fluttertoast.showToast(
              msg: 'Success',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              webPosition: 'center',
            );
            print('Update Status:$value}');
            getEmployeeData();
            getDevice();
            getDataCheckoutOnly();
            getUseDevice();
            Get.rootDelegate.popRoute();
          });
        }
      });
    }
  }

  ///Using device
  RxList<Using> lisUsing = RxList([]);
  RxList<Using> lisUsingByEmployee = RxList([]);

  void getUseDevice() {
    DeviceService.to.useDevice().then((value) {
      lisUsing.value = value.data!;
    });
  }

  getTotalDevice({required String data}) {
    lisUsingByEmployee.value = lisUsing.where((use) {
      String employeeId = use.employeeId.toString();
      return employeeId.contains(data);
    }).toList();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
