import 'package:get/get.dart';
import 'package:kst_inventory/models/checkout.dart';
import 'package:kst_inventory/models/device.dart';
import 'package:kst_inventory/models/employee.dart';
import 'package:kst_inventory/services/checkout_services.dart';
import 'package:kst_inventory/services/device_services.dart';
import 'package:kst_inventory/services/employee_services.dart';

class CheckOutController extends GetxController {
  @override
  void onInit() {
    getEmployeeData();
    getDevice();
    getDataCheckoutOnly();
    getAutoId();
    super.onInit();
  }

  ///Get Auto ID
  List<int> listCheckId = [];
  RxString checkOutAutoId=RxString('');

  void getAutoId() {
    DateTime year = DateTime.now();
    int max = 0;
    if (lisCheckout.length == 0) {
      max = 1;
    } else {
      for (int i = 0; i < lisCheckout.length; i++) {
        listCheckId
            .add(int.parse(lisCheckout[i].checkoutId.toString().substring(6)));
      }
      max = listCheckId
              .reduce((value, element) => value > element ? value : element) +
          1;
    }
    checkOutAutoId.value='CH${year.year.toString().substring(2)}${year.month.toString()}${max.toString().padLeft(4,'0')}';
  }

  ///Get Checkout Data only
  RxList<Checkout> lisCheckout = RxList([]);

  void getDataCheckoutOnly() {
    CheckoutServices.to.getCheckoutOnly().then((value) {
      lisCheckout.value = value.data!;
    });
  }

  Employee employeeData = Employee();

  ///Get Employee Data
  RxList<Employee> listEmployee = RxList([]);

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

  void checkOutDevice() {
    if (device.length == 0) {
      print('Please select at lease 1 device ');
    } else {
      CheckoutServices.to.createCheckout(data: {
        'checkoutId': 'CH002',
        'username': 'admin',
        'employeeId': employeeData.employeeId,
      }).then((value) {
        print('CheckOut:$value}');
        for (int i = 0; i < device.length; i++) {
          CheckoutServices.to.createDetail(data: {
            'checkoutId': 'CH002',
            'deviceId': device[i].toString(),
          }).then((value) {
            print('CheckOutDetail:$value}');
          });
          CheckoutServices.to.updatesStatus(data: {
            'deviceId': device[i].toString(),
          }).then((value) {
            print('Update Status:$value}');
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
