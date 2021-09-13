import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/check_out/controllers/check_out_controller.dart';
import 'package:kst_inventory/app/modules/check_out/views/check_out_detail_view.dart';
import 'package:kst_inventory/models/employee.dart';
import 'package:kst_inventory/models/employee_device.dart';
import 'package:kst_inventory/models/using_device_employee.dart';
import 'package:kst_inventory/utils/constants.dart';
import 'package:kst_inventory/utils/dialog.dart';

class CheckOutView extends GetView<CheckOutController> {
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
                  'Check out',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                _searchBox(),
                Expanded(
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [],
                          ),
                          Text(
                            'Select the employee for checkout devices',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: resultsData(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _searchBox() {
    return Container(
      margin: EdgeInsets.all(20),
      width: 500,
      child: Row(
        children: [
          Expanded(
            child: Card(
              child: Container(
                padding: EdgeInsets.all(2),
                child: TextField(
                  controller: controller.employeeValueController,
                  decoration: InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Search...',
                    suffixIcon: Icon(Icons.search),
                  ),
                  onChanged: (value) => controller.employeeValue.value = value,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            child: TextButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.only(
                      top: 20, bottom: 20, left: 20, right: 20)),
                  backgroundColor:
                      MaterialStateProperty.all(Appearance.appBarColor)),
              child: Text(
                'Search',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                controller.onSearchDataEmployee();
              },
            ),
          ),
        ],
      ),
    );
  }

  resultsData(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Obx(
          () {
            if (controller.loading.value == true) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Loading...'),
                  ],
                ),
              );
            }
            if (controller.listEmployee.length == 0) {
              return Center(
                child: Text('No data'),
              );
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => DataTable(
                        headingTextStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                        showCheckboxColumn: false,
                        columnSpacing: 25,
                        showBottomBorder: true,
                        columns: _checkOutColumn(controller.columnCheckOut),
                        rows: _checkOutRows(
                            list: controller.listEmployee, context: context)),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void showDialogCheckOut(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          elevation: 0,
          contentPadding: EdgeInsets.zero,
          actionsPadding: EdgeInsets.only(bottom: 50, right: 50),
          content: CheckOutDetailView(),
          actions: [
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black45),
                padding: MaterialStateProperty.all(
                    EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 20)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                controller.lisUsing();
              },
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Appearance.appBarColor),
                padding: MaterialStateProperty.all(
                    EdgeInsets.only(top: 20, bottom: 20, left: 50, right: 50)),
              ),
              onPressed: () {
                controller.checkOutDevice(context);
              },
              child: Text(
                'OK',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  List<DataColumn> _checkOutColumn(List<String> list) =>
      list.map((column) => DataColumn(label: Text(column))).toList();

  List<DataRow> _checkOutRows(
          {required RxList<EmployeeDev> list,
          required BuildContext context}) =>
      list.map((data) {
        int index = list.indexOf(data);
        return DataRow(
          onSelectChanged: (isSelected) {
            controller.searchTextController.clear();
            controller.employeeData = Employee(
              employeeId: data.employeeId,
              nameEn: data.nameEn,
              company: data.company,
              department: data.department,
              position: data.position,
            );

            controller.getTotalDevice(
                data: '${controller.listEmployee[index].employeeId}');
            showDialogCheckOut(context);
          },
          cells: [
            DataCell(Text('${index + 1}')),
            DataCell(VerticalDivider()),
            DataCell(Text('${data.employeeId}')),
            DataCell(VerticalDivider()),
            DataCell(Text('${controller.listEmployee[index].gender}')),
            DataCell(VerticalDivider()),
            DataCell(Text('${controller.listEmployee[index].nameLa}')),
            DataCell(VerticalDivider()),
            DataCell(Text('${controller.listEmployee[index].nameEn}')),
            DataCell(VerticalDivider()),
            DataCell(Text('${controller.listEmployee[index].nickname}')),
            DataCell(VerticalDivider()),
            DataCell(Text('${controller.listEmployee[index].email}')),
            DataCell(VerticalDivider()),
            DataCell(Text('${controller.listEmployee[index].position}')),
            DataCell(VerticalDivider()),
            DataCell(Text('${controller.listEmployee[index].department}')),
            DataCell(VerticalDivider()),
            DataCell(Text('${controller.listEmployee[index].company}')),
            DataCell(VerticalDivider()),
            DataCell(Text('${controller.listEmployee[index].device}')),
          ],
        );
      }).toList();
}
