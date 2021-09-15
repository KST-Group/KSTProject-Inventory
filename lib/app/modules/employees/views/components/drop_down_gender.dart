import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/employees/controlers/employee_controller.dart';
import 'package:flutter/material.dart';

class DropDownGender extends GetView<EmployeeController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin: EdgeInsets.only(top: 15, bottom: 15),
        child: Row(
          children: [
            Container(
              width: 150,
              margin: EdgeInsets.only(right: 20),
              child: Text(
                'Gender:',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.end,
              ),
            ),
            Container(
              width: 300,
              child: Obx(
                () => DropdownButtonFormField(
                  isDense: true,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                        EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
                  ),
                  value: controller.selectedGender,
                  hint: Text('Select gender'),
                  items: controller.genders
                      .map(
                        (data) => DropdownMenuItem(
                          child: Text(
                            data.toString(),
                          ),
                          value: data,
                        ),
                      )
                      .toList(),
                  onChanged: (value) =>
                      controller.selectedGender = value.toString(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
