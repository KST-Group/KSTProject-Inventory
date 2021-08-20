import 'package:get/get.dart';
import 'package:kst_inventory/models/departments.dart';
import 'package:kst_inventory/services/department_services.dart';

class DepartmentController extends GetxController {
  @override
  void onInit() {
    getDepartment();
    super.onInit();
  }

  ///Get all department
  var listDepartment = [].obs;

  Future getDepartment() async {
    DepartmentServices.to.getData().then((value) {
      listDepartment.value = value.data!;
    });
  }

  ///delete

  void deleteDepart({required String departId}) {
    DepartmentServices.to
        .deleteDepartment(departmentId: departId)
        .then((value) {
      getDepartment();
      print(value);
    });
  }

  ///Add data
  var department = ''.obs;
  var description = ''.obs;

  void addData() {
    DepartmentServices.to.addData(data: {
      'department': department.value,
      'description': description.value,
    }).then((value) {
      getDepartment();
      print(value);
    });
  }
}
