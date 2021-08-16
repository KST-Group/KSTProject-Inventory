import 'package:get/get.dart';

class EmployeeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  ///Filter dropdown Company
  var dropDownCompany = '1'.obs;

  void onChangeCompany(String value) {
    dropDownCompany.value = value;
  }

  ///Filter dropdown department
  var dropDownDepartment = '1'.obs;
  void onChangeDepartment(String value){
    dropDownDepartment.value=value;
  }

  ///Filter dropdown position
  var dropDownPosition = '1'.obs;
  void onChangePosition(String value){
    dropDownPosition.value=value;
  }
}
