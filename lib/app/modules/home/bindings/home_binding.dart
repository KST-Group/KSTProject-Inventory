import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/home/controllers/home_controller.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }

}