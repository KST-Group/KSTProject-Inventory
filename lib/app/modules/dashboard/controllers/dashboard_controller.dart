import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/models/device.dart';
import 'package:kst_inventory/models/using_device_employee.dart';
import 'package:kst_inventory/services/device_services.dart';
import 'package:kst_inventory/services/employee_services.dart';

class DashboardController extends GetxController {
  final List<String> columns = [
    'No',
    '',
    'KST New ID',
    '',
    'Gender',
    '',
    'Name (Lao)',
    '',
    'Nickname',
    '',
    'Name (English)',
    '',
    'Email',
    '',
    'Position',
    '',
    'Department',
    '',
    'Company',
    '',
    'Using device'
  ];

  @override
  void onInit() {
    getAllDeviceData();
    getEmployeeUsingDeviceData();
    super.onInit();
  }

  ///Get all device
  RxList<Device> listDeviceData = RxList([]);
  RxList<Device> listLaptopDevice = RxList([]);
  RxList<Device> listDesktopDevice = RxList([]);
  RxList<Device> listMobileDevice = RxList([]);

  void getAllDeviceData() {
    DeviceService.to.getAllDevice().then((value) {
      listDeviceData.value = value.data!;
      listLaptopDevice.value = listDeviceData.where((value) {
        String deviceType = value.deviceType.toString();
        return deviceType.contains('Laptop');
      }).toList();
      listDesktopDevice.value = listDeviceData.where((value) {
        String device = value.deviceType.toString();
        return device.contains('Desktop');
      }).toList();
      listMobileDevice.value = listDeviceData.where((value) {
        String device = value.deviceType.toString();
        return device.contains('Mobile');
      }).toList();
    });
  }

  ///on Search Data
  TextEditingController searchTextController = TextEditingController();
  var searchTextValue = ''.obs;
  RxList<UsingEmployee> listSearchDeviceData = RxList([]);

  void onSearchData() {
    listSearchDeviceData.value = listEmployeeUsingDevice.where((data) {
      String nameLa = data.nameLa.toString().toLowerCase().trim();
      String empId = data.employeeId.toString().toLowerCase().trim();
      String nickName = data.nickname.toString().toLowerCase().trim();
      String nameEn = data.nameEn.toString().toLowerCase().trim();
      return nameLa.contains(searchTextValue.value) ||
          empId.contains(searchTextValue.value) ||
          nickName.contains(searchTextValue.value) ||
          nameEn.contains(searchTextValue.value);
    }).toList();
  }

  ///Grt Employee Using device
  RxList<UsingEmployee> listEmployeeUsingDevice = RxList([]);

  void getEmployeeUsingDeviceData() {
    EmployeeServices.to.getDeviceUsingDataEmployee().then((value) {
      listEmployeeUsingDevice.value = value.data!;
    });
  }

  ///
  ///
  final List<String> deviceColumn = [
    'No',
    'Device ID',
    'Device Name',
    'Brand',
    'Device Type',
    'Model',
    'Service Tag/SN',
    'Computer Name',
    'Processor',
    'Main Memory',
    'Storage'
  ];
}
