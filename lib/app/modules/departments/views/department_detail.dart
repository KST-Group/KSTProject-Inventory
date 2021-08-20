import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/departments/controllers/department_controller.dart';

class DepartmentDetailView extends GetView<DepartmentController> {
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        return Scaffold(
          body: Text('Department detail'),
        );
      },
    );
  }
}
