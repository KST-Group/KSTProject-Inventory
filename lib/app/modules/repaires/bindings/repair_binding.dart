import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/repaires/controllers/repair_controller.dart';

class RepairBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<RepairController>(() => RepairController());
  }

}