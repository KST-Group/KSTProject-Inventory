import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/check_out/controllers/check_out_controller.dart';

class CheckOutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckOutController>(() => CheckOutController());
  }
}
