import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/employees/controlers/employee_controller.dart';

class EmployeeView extends GetView<EmployeeController> {
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        return Scaffold(
          body: Container(
            margin: EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Employee',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                _searchTextBox(),
                _filterBox(),
                Divider(),
                Expanded(
                  child: Container(
                    child: SingleChildScrollView(
                      child: DataTable(
                        columns: [
                          DataColumn(label: Text('No')),
                          DataColumn(label: Text('Employee ID')),
                          DataColumn(label: Text('Gender')),
                          DataColumn(label: Text('Name La')),
                          DataColumn(label: Text('Name EN')),
                          DataColumn(label: Text('Email')),
                        ],
                        rows: List.generate(100, (index) {
                          return DataRow(cells: [
                            DataCell(Text('${index + 1}')),
                            DataCell(Text('001')),
                            DataCell(Text('Male')),
                            DataCell(Text('Khamkone')),
                            DataCell(Text('Khamkone')),
                            DataCell(Text('khamkone@ksd.la')),
                          ]);
                        }),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _searchTextBox() {
    final border = const OutlineInputBorder(
      borderSide: BorderSide(),
    );
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      width: 500,
      child: TextField(
        decoration: InputDecoration(
          isDense: true,
          hintText: 'Employee ID or Name Other...',
          border: border,
          focusedBorder: border,
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  _filterBox() {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Obx(
            () => _dropDownFilter(
              data: ['1', '2', '3', '4', '5'],
              tile: 'Company',
              value: controller.dropDownCompany.value,
              onChange: (value) => controller.onChangeCompany(value),
            ),
          ),
          Obx(
            () => _dropDownFilter(
              data: ['1', '2', '3', '4', '5'],
              tile: 'Department',
              value: controller.dropDownDepartment.value,
              onChange: (value) => controller.onChangeDepartment(value),
            ),
          ),
          Obx(
            () => _dropDownFilter(
              data: ['1', '2', '3', '4', '5'],
              tile: 'Position',
              value: controller.dropDownPosition.value,
              onChange: (value) => controller.onChangePosition(value),
            ),
          ),
        ],
      ),
    );
  }

  _dropDownFilter(
      {required String tile,
      required String value,
      required ValueChanged? onChange,required List data}) {
    return Container(
      margin: EdgeInsets.only(left: 20),
      child:  Row(
          children: [
            Text('$tile:'),
            SizedBox(
              width: 10,
            ),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: DropdownButton(
                isDense: true,
                underline: Container(),
                hint: Text('Company'),
                value: value,
                items: data.map((element) {
                  return DropdownMenuItem(
                    child: Text(element),
                    value: element,
                  );
                }).toList(),
                onChanged: onChange,
              ),
            ),
          ],
      ),
    );
  }
}
