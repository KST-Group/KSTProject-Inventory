import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/positions/controllers/position_controller.dart';

class PositionBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<PositionController>(() => PositionController());
  }

}