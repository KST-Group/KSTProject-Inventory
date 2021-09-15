import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/employees/controlers/employee_controller.dart';
import 'package:flutter/material.dart';
import 'package:kst_inventory/utils/constants.dart';

import 'drop_down_company.dart';
import 'drop_down_department.dart';
import 'drop_down_gender.dart';
import 'drop_down_position.dart';
import 'text_inpt_data.dart';

class AddEmployee extends GetView<EmployeeController>{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      child: Container(
        width: MediaQuery.of(context).size.width / 3,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              height: 40,
              color: Appearance.appBarColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'New Employee',
                    style: TextStyle(color: Colors.white),
                  ),
                  IconButton(
                    tooltip: 'Close',
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.clear,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        children: [
                          Text('Employee ID:'),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${controller.employeeIdAuto.value}',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    DropDownCompany(),
                    DropDownDepartment(),
                    DropDownPosition(),
                    DropDownGender(),
                    TextInputData(
                        label: 'Name (Lao):',
                        title: 'Name (lao)',
                        onChange: (value) =>
                        controller.nameLa = value),
                    TextInputData(
                        label: 'Name (English):',
                        title: 'Name (eng)',
                        onChange: (value) =>
                        controller.nameEn = value),
                    TextInputData(
                        label: 'Nickname',
                        title: 'Nick name',
                        onChange: (value) =>
                        controller.nickname = value),
                    TextInputData(
                        label: 'Email:',
                        title: 'Email',
                        onChange: (value) =>
                        controller.email = value),
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