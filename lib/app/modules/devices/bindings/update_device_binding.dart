import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/devices/controllers/update_device_contoller.dart';


class UpdateDeviceBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<UpdateDeviceController>(() => UpdateDeviceController());
  }

}