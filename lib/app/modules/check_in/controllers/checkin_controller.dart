import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/root/views/root_view.dart';
import 'package:kst_inventory/models/check_in_detail.dart';
import 'package:kst_inventory/models/check_in_log.dart';
import 'package:kst_inventory/models/check_in_view.dart';
import 'package:kst_inventory/models/checkin.dart';
import 'package:kst_inventory/models/device.dart';
import 'package:kst_inventory/models/employee.dart';
import 'package:kst_inventory/models/employee_device.dart';
import 'package:kst_inventory/models/using_device.dart';
import 'package:kst_inventory/services/checkin_services.dart';
import 'package:kst_inventory/services/device_services.dart';
import 'package:kst_inventory/services/employee_services.dart';

class CheckInController extends GetxController {
  var loading = false.obs;

  @override
  void onInit() {
    getEmployeeData();
    getCheckInDataController();

    super.onInit();
  }

  List columnsList = [
    'No',
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
    'Using',
  ];

  final List<String> columnDevices = [
    'DeviceID',
    'Local ID',
    'Device Name',
    'Bran',
    'Device Type',
    'Model',
    'Service Tag/SN',
    'CPU',
    'RAM',
    'Hard Disk',
  ];

  ///Get employee data list
  RxList<CheckInViewModel> listEmployees = RxList([]);

  void getEmployeeData() {
    CheckInServices.to.getCheckInView().then((value) {
      listEmployees.value = value.data!.where((element) {
        int total = element.total!;
        return total.isGreaterThan(0);
      }).toList();
    });
  }

  ///Get CheckIn Data
  RxList<CheckIn> listCheckInData = RxList([]);

  void getCheckInDataController() {
    CheckInServices.to.getDataCheckIn().then((value) {
      listCheckInData.value = value.data!;
      getAutoCheckInId();
    });
  }

  ///Get Auto ID
  var autoCheckInId = ''.obs;

  ///CI2190001
  List<int> lisCheckInId = [];

  void getAutoCheckInId() {
    DateTime date = DateTime.now();
    int max = 0;
    if (listCheckInData.length == 0) {
      max = 1;
    } else {
      listCheckInData.forEach((data) {
        lisCheckInId.add(int.parse(data.checkinId.toString().substring(6)));
      });
      max = lisCheckInId
              .reduce((value, element) => value > element ? value : element) +
          1;
    }
    autoCheckInId.value =
        'CI${date.year.toString().substring(2)}${date.month}${max.toString().padLeft(5, '0')}';
  }

  ///get list device Use
  RxList<Using> listUsingDevice = RxList([]);

  void getUsingDevice({required String employeeId}) {
    DeviceService.to.useDevice().then((value) {
      listUsingDevice.value = value.data!.where((data) {
        String emp = data.employeeId.toString();
        return emp.contains(employeeId);
      }).toList();
    });
  }

  ///Search Employee
  TextEditingController searchController = TextEditingController();
  var searchTextValue = ''.obs;
  RxList<CheckInViewModel> listEmployeesSearch = RxList([]);

  void getSearchEmployeeData() {
    listEmployeesSearch.value = listEmployees.where((data) {
      String employeeId = data.employeeId.toString().toLowerCase().trim();
      return employeeId.contains(searchTextValue.value);
    }).toList();
  }

  ///Selected Device CheckIn
  RxList<Using> selectedDevice = RxList([]);
  var listDeviceId = [].obs;

  void onSelectedDeviceCheckIn() {
    listDeviceId.clear();
    selectedDevice.forEach((device) {
      listDeviceId.add(device.deviceId);
    });
  }

  ///Check In
  void checkInDevice(BuildContext context) async {
    if (listDeviceId.length == 0) {
      print('Please select device for check in');
    } else {
      loading.value = true;
      CheckInViewModel? employee = Get.rootDelegate.arguments();
      print(employee!.employeeId);
      CheckInServices.to
          .createCheckIn(
              data: CheckIn(
        checkinId: autoCheckInId.value,
        employeeId: employee.employeeId,
        username: username,
      ).toMap())
          .then((value) {
        print(value['message']);

        if (value['error'] == false) {
          for (int i = 0; i < listDeviceId.length; i++) {
            /// add CheckIn Detail
            addCheckInDetail(i);

            ///Delete from check out
            delCheckOut(i);

            ///Update Status
            updateStatusDevice(i);

            ///Add Log
            addCheckInLog(
                data: CheckInLog(
              checkinId: autoCheckInId.value.toString(),
              deviceId: listDeviceId[i].toString(),
              employeeId: employee.employeeId.toString(),
              descriptions: descriptionController.text,
            ).toMap());
          }
          listDeviceId.clear();
          getEmployeeData();
          getCheckInDataController();
          loading.value = false;
          Get.rootDelegate
              .popRoute()
              .then((value) => Get.rootDelegate.popRoute());
        }
      });
    }
  }

  ///add check in detail
  void addCheckInDetail(int index) {
    CheckInServices.to
        .addCheckIn(
            data: Details(
      checkinId: autoCheckInId.value,
      deviceId: listDeviceId[index].toString(),
    ).toMap())
        .then((value) {
      print(value['message']);
    });
  }

  /// Delete data from check out
  void delCheckOut(int index) {
    CheckInServices.to
        .delCheckOutDetail(deviceId: listDeviceId[index])
        .then((value) {
      print(value['message']);
    });
  }

  ///Update device status

  void updateStatusDevice(int index) {
    DeviceService.to
        .updateStatus(deviceId: listDeviceId[index], status: 'In Stock')
        .then((value) {
      print(value['message']);
    });
  }

  ///Add log Check
  TextEditingController descriptionController = TextEditingController();

  void addCheckInLog({required Map<String, dynamic> data}) {
    CheckInServices.to.addCheckInLog(data: data).then((value) {
      print(value['message']);
    });
  }
}
