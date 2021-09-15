import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/employees/controlers/employee_controller.dart';
import 'package:kst_inventory/models/companys.dart';
import 'package:kst_inventory/models/departments.dart';
import 'package:kst_inventory/models/position.dart';
import 'package:kst_inventory/utils/constants.dart';

import 'components/add_employee.dart';
import 'components/update_employee.dart';

class EmployeeView extends GetView<EmployeeController> {
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        return Scaffold(
          backgroundColor: Appearance.backGroundColor,
          body: Container(
            margin: EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Employees',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Divider(),
                Expanded(
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                _searchTextBox(),
                                addButton(context: context),
                              ],
                            ),
                            Row(
                              children: [
                                Obx(
                                  () => DataTable(
                                    columns: [
                                      DataColumn(label: Text('No')),
                                      DataColumn(label: Text('Employee ID')),
                                      DataColumn(label: Text('Gender')),
                                      DataColumn(label: Text('Name (Lao)')),
                                      DataColumn(label: Text('Name (English)')),
                                      DataColumn(label: Text('Nick Name')),
                                      DataColumn(label: Text('Email')),
                                      DataColumn(label: Text('Position')),
                                      DataColumn(label: Text('Department')),
                                      DataColumn(label: Text('Company')),
                                      DataColumn(label: Text('Action')),
                                    ],
                                    rows:
                                        controller.listEmployee.map((employee) {
                                      int index = controller.listEmployee
                                          .indexOf(employee);
                                      return DataRow(cells: [
                                        DataCell(Text('${index + 1}')),
                                        DataCell(
                                            Text('${employee.employeeId}')),
                                        DataCell(Text('${employee.gender}')),
                                        DataCell(Text('${employee.nameLa}')),
                                        DataCell(Text('${employee.nameEn}')),
                                        DataCell(Text(
                                            '${employee.nickname ?? 'No Data'}')),
                                        DataCell(Text(
                                            '${employee.email ?? 'No data'}')),
                                        DataCell(Text(
                                            '${employee.position ?? 'No data'}')),
                                        DataCell(Text(
                                            '${employee.department ?? 'No data'}')),
                                        DataCell(Text(
                                            '${employee.company ?? 'No data'}')),
                                        DataCell(
                                          Row(
                                            children: [
                                              InkWell(
                                                child: Text(
                                                  'Update',
                                                  style: TextStyle(
                                                      color: Colors.amber),
                                                ),
                                                onTap: () {
                                                  ///Get Data

                                                  ///Company Data

                                                  List<Company> comp =
                                                      controller.listCompany
                                                          .where((data) {
                                                    String company =
                                                        data.company.toString();
                                                    return company.contains(
                                                        employee.company
                                                            .toString());
                                                  }).toList();
                                                  controller.selectedCompany =
                                                      comp[0].companyId;

                                                  ///Department
                                                  List<Department> depart =
                                                      controller.listDepartment
                                                          .where((data) {
                                                    String dep = data.department
                                                        .toString();
                                                    return dep.contains(employee
                                                        .department
                                                        .toString());
                                                  }).toList();

                                                  controller
                                                          .selectedDepartment =
                                                      depart[0].departmentId;

                                                  ///Position
                                                  List<Position> pos =
                                                      controller.listPosition
                                                          .where((data) {
                                                    String po = data.position
                                                        .toString();
                                                    return po.contains(employee
                                                        .position
                                                        .toString());
                                                  }).toList();

                                                  controller.selectedPosition =
                                                      pos[0].positionId;

                                                  ///Gender
                                                  controller.selectedGender =
                                                      employee.gender;
                                                  controller.nameLaController
                                                          .text =
                                                      employee.nameLa
                                                          .toString();
                                                  controller.nameEnController
                                                          .text =
                                                      employee.nameEn
                                                          .toString();
                                                  controller.nicknameController
                                                          .text =
                                                      employee.nickname
                                                          .toString();
                                                  controller.emailController
                                                          .text =
                                                      employee.email.toString();

                                                  showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        AlertDialog(
                                                      actionsPadding:
                                                          EdgeInsets.only(
                                                              right: 10,
                                                              bottom: 10),
                                                      backgroundColor:
                                                          Appearance
                                                              .backGroundColor,
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      content: UpdateEmployee(
                                                        employeeId: employee
                                                            .employeeId
                                                            .toString(),
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text('Cancel'),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {

                                                            controller.updateEmployee(
                                                                employeeId: employee
                                                                    .employeeId
                                                                    .toString(),
                                                                context:
                                                                    context);
                                                          },
                                                          child: Text('OK'),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              InkWell(
                                                child: Text(
                                                  'Delete',
                                                  style: TextStyle(
                                                      color: Colors.redAccent),
                                                ),
                                                onTap: () {
                                                  _dialogOptionDelete(
                                                      context, index);
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                      ]);
                                    }).toList(),
                                    headingRowColor: MaterialStateProperty.all(
                                        Appearance.backGroundColor),
                                    headingTextStyle:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
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
      borderSide: BorderSide.none,
    );
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      width: 500,
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Appearance.backGroundColor,
          isDense: true,
          hintText: 'Search...',
          border: border,
          focusedBorder: border,
          suffixIcon: Icon(Icons.search),
        ),
        onChanged: (value) {
          controller.onSearch(key: value.toString());
        },
      ),
    );
  }

  addButton({required BuildContext context}) {
    return Container(
      margin: EdgeInsets.only(left: 20),
      child: InkWell(
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.green),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.add,
                color: Colors.white,
              ),
              Text(
                'New Employee',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        onTap: () {
          controller.selectedCompany = null;
          controller.selectedDepartment = null;
          controller.selectedPosition = null;
          controller.selectedGender = null;
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Appearance.backGroundColor,
                contentPadding: EdgeInsets.zero,
                actionsPadding: EdgeInsets.only(bottom: 20, right: 10),
                content: AddEmployee(),
                actions: [
                  TextButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      controller.addEmployeeData(context);
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  void _dialogOptionDelete(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Warning'),
          content: Text('Do you want to delete?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                controller.deleteEmployeeData(
                  employeeId:
                      controller.listEmployee[index].employeeId.toString(),
                );
              },
            )
          ],
        );
      },
    );
  }
}
