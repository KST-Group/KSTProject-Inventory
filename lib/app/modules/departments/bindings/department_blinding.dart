
import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/departments/controllers/department_controller.dart';

class DepartmentBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<DepartmentController>(() => DepartmentController());
  }

}