import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/settings/controllers/setting_controller.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingController>(() => SettingController());
  }
}
