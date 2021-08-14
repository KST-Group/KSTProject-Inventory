import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/devices/controllers/device_controller.dart';

class DeviceBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<DeviceController>(() => DeviceController());
  }

}