import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/check_in/controllers/checkin_controller.dart';
import 'package:kst_inventory/app/routes/app_routes.dart';
import 'package:kst_inventory/utils/constants.dart';

class CheckInView extends GetView<CheckInController> {
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        return Scaffold(
          body: Container(
            margin: EdgeInsets.all(20),
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
                          Divider(),
                          SizedBox(
                            height: 15,
                          ),
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
                                    showCheckboxColumn: false,
                                    headingTextStyle:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    columns: _createColumn(),
                                    rows: _createRows(),
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
              decoration: InputDecoration(
                  isDense: true,
                  border: border,
                  focusedBorder: border,
                  hintText: 'Employee ID or Name'),
            ),
          ),
        ),
      ],
    );
  }

  List<DataColumn> _createColumn() => controller.columnsList
      .map((column) => DataColumn(label: Text(column)))
      .toList();

  List<DataRow> _createRows() => controller.listEmployees
      .map(
        (row) => DataRow(
          onSelectChanged: (value) {
            Get.rootDelegate
                .toNamed(Routes.CHECKIN_DETAIL(row.employeeId.toString()));
          },
          cells: [
            DataCell(Text(row.employeeId.toString())),
            DataCell(Text(row.gender.toString())),
            DataCell(Text(row.nameLa.toString())),
            DataCell(Text(row.nameEn.toString())),
            DataCell(Text(row.nickname.toString())),
            DataCell(Text(row.email.toString())),
            DataCell(
              TextButton(
                child: Text('CheckIn'),
                onPressed: () {},
              ),
            ),
          ],
        ),
      )
      .toList();
}
