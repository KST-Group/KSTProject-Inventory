import 'package:get/get.dart';
import 'package:kst_inventory/models/device.dart';
import 'package:kst_inventory/services/device_services.dart';

class RepairController extends GetxController {
  @override
  void onInit() {
    getDevice();
    super.onInit();
  }

  final List<String> columnDevice = [
    'No',
    '',
    'Devcie ID',
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

  RxList<Device> listDevice = RxList([]);
  RxList<Device> listDeviceRepair = RxList([]);

  Future getDevice() async {
    DeviceService.to.getAllDevice().then((value) {
      listDeviceRepair.value= listDevice.value = value.data!.where((data) {
        String status = data.statuss.toString();
        return !status.contains('Repair');
      }).toList();
      listDevice.value = value.data!.where((data) {
        String status = data.statuss.toString();
        return status.contains('Repair');
      }).toList();
    });
  }
}
