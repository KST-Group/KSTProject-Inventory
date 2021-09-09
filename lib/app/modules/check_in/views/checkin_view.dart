import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/check_in/controllers/checkin_controller.dart';
import 'package:kst_inventory/app/routes/app_routes.dart';
import 'package:kst_inventory/models/employee_device.dart';
import 'package:kst_inventory/utils/constants.dart';

class CheckInView extends GetView<CheckInController> {
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        return Scaffold(
          body: Container(
            padding: EdgeInsets.all(20),
            color: Appearance.backGroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Device Check In',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Employee'),
                          SizedBox(
                            height: 15,
                          ),
                          _searchTextBox(),
                          SizedBox(
                            height: 20,
                          ),
                          Text('Employee using device'),
                          Divider(),
                          // SizedBox(
                          //   height: 15,
                          // ),
                          Expanded(child: SingleChildScrollView(
                            child: Container(
                              child: Obx(
                                () {
                                  if (controller.listEmployees.length == 0) {
                                    return Center(
                                      child: Text('No data'),
                                    );
                                  }
                                  return DataTable(
                                    headingRowColor: MaterialStateProperty.all(Appearance.backGroundColor),
                                    showBottomBorder: true,
                                    showCheckboxColumn: false,
                                    headingTextStyle:
                                        TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                                    columns: _createColumn(),
                                    rows: _createRows(
                                      list: controller.searchTextValue.value
                                                  .length ==
                                              0
                                          ? controller.listEmployees
                                          : controller.listEmployeesSearch,
                                    ),
                                  );
                                },
                              ),
                            ),
                          )),
                        ],
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
    final border = const OutlineInputBorder(borderSide: BorderSide());
    return Row(
      children: [
        SizedBox(
          width: 20,
        ),
        Flexible(
          flex: 1,
          child: Container(
            width: 500,
            child: TextField(
              controller: controller.searchController,
              decoration: InputDecoration(
                isDense: true,
                border: border,
                focusedBorder: border,
                hintText: 'Employee ID or Name',
              ),
              onChanged: (value) {
                controller.searchTextValue.value = value;
                controller.getSearchEmployeeData();
              },
            ),
          ),
        ),
      ],
    );
  }

  List<DataColumn> _createColumn() => controller.columnsList
      .map((column) => DataColumn(label: Text(column)))
      .toList();

  List<DataRow> _createRows({required RxList<EmployeeDev> list}) => list
      .map(
        (row) {
          int index=list.indexOf(row);
          return DataRow(


          onSelectChanged: (value) {
            controller.getUsingDevice(employeeId: row.employeeId.toString());
            Get.rootDelegate.toNamed(
              Routes.CHECKIN_DETAIL(
                row.employeeId.toString(),
              ),
              arguments: row,
            );
          },
          cells: [
            DataCell(Text('${index+1}')),
            DataCell(Text(row.employeeId.toString())),
            DataCell(VerticalDivider()),
            DataCell(Text(row.gender.toString())),
            DataCell(VerticalDivider()),
            DataCell(Text(row.nameLa.toString())),
            DataCell(VerticalDivider()),
            DataCell(Text(row.nameEn.toString())),
            DataCell(VerticalDivider()),
            DataCell(Text(row.nickname.toString())),
            DataCell(VerticalDivider()),
            DataCell(Text(row.email.toString())),
            DataCell(VerticalDivider()),
            DataCell(Text('${row.device.toString()} Device')),
          ],
        );
        },
      )
      .toList();
}
