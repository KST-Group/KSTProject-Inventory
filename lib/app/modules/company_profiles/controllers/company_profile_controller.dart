import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/companys/controllers/company_controller.dart';
import 'package:kst_inventory/models/departments.dart';
import 'package:kst_inventory/services/company_services.dart';

class CompanyProfileController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  ///Get Detail
  var listDepartment = [].obs;

  Future getDepartment({required String companyId}) async {
    CompanyService.to.getDepartment(companyId: companyId).then((value) {
      listDepartment.value = value.data!;
      print(listDepartment.length);
    });
  }
}
