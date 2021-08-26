import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/check_out/controllers/check_out_controller.dart';
import 'package:kst_inventory/app/modules/check_out/views/check_out_detail_view.dart';
import 'package:kst_inventory/models/employee.dart';
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
                          Text('Select the employee for checkout devices'),
                          _searchBox(),
                          Row(
                            children: [
                              Text('Employees'),
                              SizedBox(
                                width: 10,
                              ),
                              Obx(() {
                                if (controller.employeeValue.isEmpty ||
                                    controller.employeeValue.value == '' ||
                                    controller.employeeValue.value == null) {
                                  return Container();
                                }
                                return TextButton(
                                    onPressed: () {
                                      controller.employeeValueController
                                          .clear();
                                      controller.employeeValue.value = '';
                                      controller.getEmployeeData();
                                    },
                                    child: Text('Clear'));
                              }),
                            ],
                          ),
                          SizedBox(
                            width: 800,
                            child: Divider(),
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
            child: TextField(
              controller: controller.employeeValueController,
              decoration: InputDecoration(
                isDense: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
                hintText: 'Type employee data',
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (value) => controller.employeeValue.value = value,
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
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DataTable(
                  columns: [
                    DataColumn(label: Text('No')),
                    DataColumn(label: Text('ID')),
                    DataColumn(label: Text('Gender')),
                    DataColumn(label: Text('Name (Lao)')),
                    DataColumn(label: Text('Name (Eng)')),
                    DataColumn(label: Text('Nickname')),
                    DataColumn(label: Text('Email')),
                    DataColumn(label: Text('Option')),
                  ],
                  rows: List.generate(controller.listEmployee.length, (index) {
                    return DataRow(
                      cells: [
                        DataCell(Text('${index + 1}')),
                        DataCell(Text(
                            '${controller.listEmployee[index].employeeId}')),
                        DataCell(
                            Text('${controller.listEmployee[index].gender}')),
                        DataCell(
                            Text('${controller.listEmployee[index].nameLa}')),
                        DataCell(
                            Text('${controller.listEmployee[index].nameEn}')),
                        DataCell(
                            Text('${controller.listEmployee[index].nickname}')),
                        DataCell(
                            Text('${controller.listEmployee[index].email}')),
                        DataCell(TextButton(
                          child: Text('Checkout'),
                          onPressed: () {
                            controller.employeeData = Employee(
                              employeeId:
                                  controller.listEmployee[index].employeeId,
                              nameEn: controller.listEmployee[index].nameEn,
                              company: controller.listEmployee[index].company,
                              department:
                                  controller.listEmployee[index].department,
                              position: controller.listEmployee[index].position,
                            );

                            showDialogCheckOut(context);
                          },
                        )),
                      ],
                    );
                  }),
                ),
              ],
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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Check out',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              )
            ],
          ),
          content: CheckOutDetailView(),
          actions: [
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black45),
                padding: MaterialStateProperty.all(EdgeInsets.all(15)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
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
                    EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                controller.checkOutDevice();
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
}
