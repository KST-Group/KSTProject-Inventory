import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/employees/controlers/employee_controller.dart';
import 'package:flutter/material.dart';
import 'package:kst_inventory/app/modules/employees/views/components/drop_down_company.dart';
import 'package:kst_inventory/app/modules/employees/views/components/drop_down_department.dart';
import 'package:kst_inventory/app/modules/employees/views/components/drop_down_gender.dart';
import 'package:kst_inventory/app/modules/employees/views/components/drop_down_position.dart';
import 'package:kst_inventory/utils/constants.dart';

import 'text_inpt_data.dart';

class UpdateEmployee extends GetView<EmployeeController> {
  final String employeeId;

  UpdateEmployee({required this.employeeId});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Appearance.backGroundColor,
      height: 700,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              color: Colors.amber,
              padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Update Employee',
                    style: TextStyle(color: Colors.white),
                  ),
                  IconButton(
                      tooltip: 'Close',
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(
                        Icons.clear,
                        color: Colors.redAccent,
                      )),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 100, top: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Employee ID: $employeeId'),
                    DropDownCompany(),
                    DropDownDepartment(),
                    DropDownPosition(),
                    DropDownGender(),
                    TextInputData(
                        controller: controller.nameLaController,
                        label: 'Name (Lao):',
                        onChange: (value) => controller.nameLa = value),
                    TextInputData(
                        controller: controller.nameEnController,
                        label: 'Name (English):',
                        onChange: (value) => controller.nameEn = value),
                    TextInputData(
                        controller: controller.nicknameController,
                        label: 'Nickname',
                        onChange: (value) => controller.nickname = value),
                    TextInputData(
                        controller: controller.emailController,
                        label: 'Email:',
                        onChange: (value) => controller.email = value),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
