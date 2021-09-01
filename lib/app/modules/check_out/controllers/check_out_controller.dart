import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/models/checkout.dart';
import 'package:kst_inventory/models/device.dart';
import 'package:kst_inventory/models/employee.dart';
import 'package:kst_inventory/services/checkout_services.dart';
import 'package:kst_inventory/services/device_services.dart';
import 'package:kst_inventory/services/employee_services.dart';

class CheckOutController extends GetxController {
  ///Global
  RxBool loading = RxBool(false);

  // List<String>columns=[
  //   // DataColumn(label: Text('No')),
  //   // DataColumn(label: Text('ID')),
  //   // DataColumn(label: Text('Gender')),
  //   // DataColumn(label: Text('Name (Lao)')),
  //   // DataColumn(label: Text('Name (Eng)')),
  //   // DataColumn(label: Text('Nickname')),
  //   // DataColumn(label: Text('Email')),
  //   // DataColumn(label: Text('Option')),
  // ];
  final List<String> columnsDevice=[
    'DeviceID',
    '',
    'LocalID',
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
    '',
    'Status'
  ];

  @override
  void onInit() {

    getEmployeeData();
    getDevice();
    getDataCheckoutOnly();
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

  ///Get Employee Data
  RxList<Employee> listEmployee = RxList([]);

  void getEmployeeData() async {
    loading.value = true;
    await Future.delayed(Duration(milliseconds: 3));
    EmployeeServices.to.getDataEmployee().then((value) {
      listEmployee.value = value.data!;

      loading.value = false;
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
        return status.contains('empty');
      }).toList();
    });
  }

  ///Search Device Checkout
  RxList<Device> listSearchDevice = RxList([]);
  TextEditingController searchTextController=TextEditingController();
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

  Future checkOutDevice() async {
    if (device.length == 0) {
      print('Please select at lease 1 device ');
    } else {
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
          CheckoutServices.to.updatesStatus(data: {
            'deviceId': device[i].toString(),
          }).then((value) {
            Fluttertoast.showToast(
                msg: 'Success',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER);
            print('Update Status:$value}');
            getEmployeeData();
            getDevice();
            getDataCheckoutOnly();
          });
        }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
