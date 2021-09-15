import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/models/device.dart';
import 'package:kst_inventory/models/using_device.dart';
import 'package:kst_inventory/models/using_device_employee.dart';
import 'package:kst_inventory/services/device_services.dart';
import 'package:kst_inventory/services/employee_services.dart';
import 'package:kst_inventory/utils/save_file.dart';
import 'dart:convert';
import "dart:html";

import 'package:syncfusion_flutter_xlsio/xlsio.dart';

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
  RxList<Device> listUsingDevice = RxList([]);
  RxList<Device> listStockDevice = RxList([]);
  RxList<Device> listIssueDevice = RxList([]);

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
      listUsingDevice.value = listDeviceData.where((value) {
        String status = value.statuss.toString();
        return status.contains('In use');
      }).toList();
      listStockDevice.value = listDeviceData.where((value) {
        String status = value.statuss.toString();
        return status.contains('In Stock');
      }).toList();
      listIssueDevice.value = listDeviceData.where((value) {
        String status = value.statuss.toString();
        return status.contains('Repair');
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
  RxList<Using> listUsingDeviceData = RxList([]);

  void getDeviceUsing(String data) {
    DeviceService.to.useDevice().then((value) {
      listUsingDeviceData.value = value.data!.where((element) {
        String employeeId = element.employeeId.toString();
        return employeeId.contains(data);
      }).toList();
    });
  }

  ///Excel

  Future<void> createExcel({required UsingEmployee data}) async {
// Create a new Excel Document.
    final Workbook workbook = Workbook();

// Accessing worksheet via index.
    final Worksheet sheet = workbook.worksheets[0];
    sheet.showGridlines = false;

// Set the text value.
    sheet.getRangeByName('B2').setText('Device Activity');

    sheet.getRangeByName('B3').setText('Employee ID');
    sheet.getRangeByName('D3').setText(data.employeeId.toString());

    sheet.getRangeByName('B4').setText('Gender');
    sheet.getRangeByName('D4').setText(data.gender.toString());

    sheet.getRangeByName('B5').setText('Name (Lao)');
    sheet.getRangeByName('D5').setText(data.nameLa.toString());

    sheet.getRangeByName('B6').setText('Name (Eng)');
    sheet.getRangeByName('D6').setText(data.nameEn.toString());

    sheet.getRangeByName('B7').setText('Nickname');
    sheet.getRangeByName('D7').setText(data.nickname.toString());

    sheet.getRangeByName('B8').setText('Position');
    sheet.getRangeByName('D8').setText(data.position.toString());

    sheet.getRangeByName('B9').setText('Department');
    sheet.getRangeByName('D9').setText(data.department.toString());

    sheet.getRangeByName('B10').setText('Company');
    sheet.getRangeByName('D10').setText(data.company.toString());

    sheet.getRangeByName('B11').setText('Email');
    sheet.getRangeByName('D11').setText(data.email.toString());

    sheet.getRangeByName('B13').setText('List Device');

    ///Column
    for (int col = 2; col < deviceColumn.length + 2; col++) {
      sheet.getRangeByIndex(14, col).text = "${deviceColumn[col - 2]}";
      sheet.getRangeByIndex(2, col + 1).columnWidth = 20;
    }

    ///Create rows
    for (int row = 15; row < listUsingDeviceData.length + 15; row++) {
      sheet.getRangeByIndex(row, 2).text = '${row - 14}';
      sheet.getRangeByIndex(row, 3).text =
          "${listUsingDeviceData[row - 15].deviceId}";
      sheet.getRangeByIndex(row, 4).text =
          "${listUsingDeviceData[row - 15].deviceName}";
      sheet.getRangeByIndex(row, 5).text =
          "${listUsingDeviceData[row - 15].brand}";
      sheet.getRangeByIndex(row, 6).text =
          "${listUsingDeviceData[row - 15].deviceType}";
      sheet.getRangeByIndex(row, 7).text =
          "${listUsingDeviceData[row - 15].model}";
      sheet.getRangeByIndex(row, 8).text =
          "${listUsingDeviceData[row - 15].servicetagSn}";
      sheet.getRangeByIndex(row, 9).text =
          "${listUsingDeviceData[row - 15].deviceName}";
      sheet.getRangeByIndex(row, 10).text =
          "${listUsingDeviceData[row - 15].cpus}";
      sheet.getRangeByIndex(row, 11).text =
          "${listUsingDeviceData[row - 15].ram}";
      sheet.getRangeByIndex(row, 12).text =
          "${listUsingDeviceData[row - 15].hardisk}";
    }

// Save and dispose the document.
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

//Download the output file in web.
    AnchorElement(
        href:
            "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
      ..setAttribute("download", "${data.employeeId}.xlsx")
      ..click();
  }
}
