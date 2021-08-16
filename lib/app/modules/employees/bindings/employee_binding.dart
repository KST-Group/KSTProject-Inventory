import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/employees/controlers/employee_controller.dart';

class EmployeeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<EmployeeController>(() => EmployeeController());
  }

}