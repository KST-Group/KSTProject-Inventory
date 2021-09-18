import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/reports/controllers/report_controller.dart';

class ReportBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ReportController>(() => ReportController());
  }

}