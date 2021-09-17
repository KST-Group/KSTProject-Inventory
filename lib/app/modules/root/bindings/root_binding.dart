import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/root/controllers/root_controller.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RootController>(() => RootController());
  }
}