import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/users/controllers/user_controller.dart';

class UserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserController>(() => UserController());
  }
}
