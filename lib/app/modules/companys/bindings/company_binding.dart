import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/companys/controllers/company_controller.dart';

class CompanyBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<CompanyController>(() => CompanyController());
  }
}