import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/models/device.dart';
import 'package:kst_inventory/models/employee_using.dart';
import 'package:kst_inventory/models/receive_log.dart';
import 'package:kst_inventory/models/repaie_device.dart';
import 'package:kst_inventory/models/repair_log.dart';
import 'package:kst_inventory/models/repairs.dart';
import 'package:kst_inventory/models/using_device.dart';
import 'package:kst_inventory/services/device_services.dart';
import 'package:kst_inventory/services/employee_services.dart';
import 'package:kst_inventory/services/repair_services.dart';

class RepairController extends GetxController {
  @override
  void onInit() {
    getDevice();
    getRepairData();
    getDeviceRepair();
    super.onInit();
  }

  final List<String> columnRepair = [
    'No',
    '',
    'Device ID',
    '',
    'Device Type',
    '',
    'Status',
    '',
    'Join Domain',
    '',
    'Brand',
    '',
    'Model',
    '',
    'Service Tag/SN',
    '',
    'Computer Name',
    '',
    'Processor',
    '',
    'Main Memory',
    '',
    'Storage',
  ];
  final List<String> columnDevice = [
    'No',
    '',
    'Device ID',
    '',
    'Device Type',
    '',
    'Status',
    '',
    'Join Domain',
    '',
    'Brand',
    '',
    'Model',
    '',
    'Service Tag/SN',
    '',
    'Computer Name',
    '',
    'Processor',
    '',
    'Main Memory',
    '',
    'Storage',
    '',
    'Description',
    '',
    'Date'
  ];

  RxList<Device> listDevice = RxList([]);
  RxList<Device> listDeviceRepair = RxList([]);

  Future getDevice() async {
    DeviceService.to.getAllDevice().then((value) {
      listDeviceRepair.value = listDevice.value = value.data!.where((data) {
        String status = data.statuss.toString();
        return !status.contains('Repair');
      }).toList();
      listDevice.value = value.data!.where((data) {
        String status = data.statuss.toString();
        return status.contains('Repair');
      }).toList();
    });
  }

  ///Get Repair Data
  RxList<Repair> listRepairs = RxList([]);

  void getRepairData() {
    RepairServices.to.getRepairs().then((value) {
      listRepairs.value = value.data!;
      getRepairId();
    });
  }

  /// Get RepairId
  List<int> listRepairId = [];
  var repairId = ''.obs;

  void getRepairId() {
    DateTime year = DateTime.now();
    int max = 0;
    if (listRepairs.length == 0) {
      max = 1;
    } else {
      for (int i = 0; i < listRepairs.length; i++) {
        listRepairId
            .add(int.parse(listRepairs[i].repairId.toString().substring(6)));
      }
      max = listRepairId
              .reduce((value, element) => value > element ? value : element) +
          1;
    }
    repairId.value =
        'RP${year.year.toString().substring(2)}${year.month.toString()}${max.toString().padLeft(4, '0')}';
  }

  ///Get Using device
  RxList<Using> listUsing = RxList([]);
  RxString employee = RxString('');

  void usingByEmployee({required String data}) {
    DeviceService.to.useDevice().then(
      (value) {
        listUsing.value = value.data!.where((element) {
          String deviceId = element.deviceId.toString();
          return deviceId.contains(data);
        }).toList();
        if (listUsing.length == 0) {
          employee.value = '-';
        } else {
          employee.value = listUsing[0].employeeId.toString();
        }
      },
    );
  }

  ///Add Repair
  TextEditingController descriptions = TextEditingController();

  void addRepairData({required String deviceId}) {
    RepairServices.to
        .addRepair(
            data: Repair(
      employeeId: employee.toString(),
      deviceId: deviceId,
      username: 'admin',
      repairId: repairId.value,
      repairDate: DateTime.now(),
      descriptions: descriptions.text,
    ).toMap())
        .then((value) {
      if (value['error'] == false) {
        ///Update
        updateDevice(deviceId: deviceId, status: 'Repair');

        ///Logg
        addLog(
            data: RepairLog(
          deviceId: deviceId,
          descriptions: descriptions.text,
          repairId: repairId.value,
          employeeId: employee.value,
          logDate: DateTime.now(),
        ).toMap());

        getDevice();
        getRepairData();
        Get.rootDelegate.popRoute();
        getDeviceRepair();
        Fluttertoast.showToast(msg: 'Success', webPosition: 'center');
        print(value['message']);
      } else {
        print(value['message']);
      }
    });
  }

  ///Update device
  void updateDevice({required String deviceId, required status}) {
    DeviceService.to
        .updateStatus(deviceId: deviceId, status: status)
        .then((value) {
      print(value['message']);
    });
  }

  ///Add Log
  void addLog({required Map<String, dynamic> data}) {
    RepairServices.to.addRepairLog(data: data).then((value) {
      print(value['message']);
    });
  }

  void delRepair({required RepairDevice device}) {
    RepairServices.to
        .delRepair(deviceId: device.deviceId.toString())
        .then((value) {
      if (listEmployeeByDeviceId.length == 0) {
        updateDevice(deviceId: device.deviceId.toString(), status: 'In Stock');
      } else {
        updateDevice(deviceId: device.deviceId.toString(), status: 'In use');
      }
      getDevice();
      getRepairData();
      getDeviceRepair();
      Get.rootDelegate.popRoute();
      Fluttertoast.showToast(msg: 'Success', webPosition: 'center');
      print(value['error']);
      if (value['error'] == false) {
        addLogReceive(
            data: ReceiveLog(
          deviceId: device.deviceId.toString(),
          employeeId: employee.value,
          descriptions: descriptionController.text,
          repairId: device.repairId.toString(),
        ).toMap());
      }
    });
  }

  ///Get Device Repair
  RxList<RepairDevice> lisRepairDevice = RxList([]);

  void getDeviceRepair() {
    RepairServices.to.getRepairsDevice().then((value) {
      lisRepairDevice.value = value.data!;
    });
  }

  ///Get Employee
  RxList<EmpUsing> listEmployeeByDeviceId = RxList([]);

  void getEmployeeByDeviceId({required String deviceId}) {
    EmployeeServices.to.getEmployeeByDeviceId(deviceId: deviceId).then((value) {
      listEmployeeByDeviceId.value = value.data!;
      if (listEmployeeByDeviceId.length == 0) {
        print('Empty');
      } else {
        print('Using');
      }
    });
  }

  ///add Log receive
  TextEditingController descriptionController = TextEditingController();

  void addLogReceive({required Map<String, dynamic> data}) {
    RepairServices.to.addReceiveLog(data: data).then((value) {
      print(value['message']);
    });
  }
}
