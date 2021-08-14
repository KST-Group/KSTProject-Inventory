import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/check_in/controllers/checkin_controller.dart';

class CheckInBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<CheckInController>(() => CheckInController());

  }

}