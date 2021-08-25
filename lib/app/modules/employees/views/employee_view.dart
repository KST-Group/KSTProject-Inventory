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
                Text('Filter'),
                _filterBox(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    addButton(context: context),
                  ],
                ),
                Divider(),
                Expanded(
                  child: Obx(
                    () {
                      if (controller.listEmployee.length == 0) {
                        return Container(
                          child: Text('No data'),
                        );
                      }
                      return Container(
                        child: SingleChildScrollView(
                          child: Row(
                            children: [
                              DataTable(
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
                                  DataColumn(label: Text('Option')),
                                ],
                                rows: List.generate(
                                    controller.listEmployee.length, (index) {
                                  return DataRow(cells: [
                                    DataCell(Text('${index + 1}')),
                                    DataCell(Text(
                                        '${controller.listEmployee[index].employeeId}')),
                                    DataCell(Text(
                                        '${controller.listEmployee[index].gender}')),
                                    DataCell(Text(
                                        '${controller.listEmployee[index].nameLa}')),
                                    DataCell(Text(
                                        '${controller.listEmployee[index].nameEn}')),
                                    DataCell(Text(
                                        '${controller.listEmployee[index].nickname ?? 'No Data'}')),
                                    DataCell(Text(
                                        '${controller.listEmployee[index].email ?? 'No data'}')),
                                    DataCell(Text(
                                        '${controller.listEmployee[index].position ?? 'No data'}')),
                                    DataCell(Text(
                                        '${controller.listEmployee[index].department ?? 'No data'}')),
                                    DataCell(Text(
                                        '${controller.listEmployee[index].company ?? 'No data'}')),
                                    DataCell(IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        _dialogOptionDelete(context, index);
                                      },
                                    )),
                                  ]);
                                }),
                                dividerThickness: 2,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
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
        onChanged: (value) {
          controller.onSearch(key: value.toString());
        },
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
            () => Container(
              margin: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text('Position:'),
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
                      hint: Text('Position'),
                      value: controller.dropDownPosition.value,
                      items: controller.listPosition.map((element) {
                        return DropdownMenuItem(
                          child: Text(element.position.toString()),
                          value: element.position.toString(),
                        );
                      }).toList(),
                      onChanged: (value) {
                        controller.onChangePosition(value.toString());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Obx(
            () => Container(
              margin: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text('Department:'),
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
                      hint: Text('Department'),
                      value: controller.dropDownDepartment.value,
                      items: controller.listDepartment.map((element) {
                        return DropdownMenuItem(
                          child: Text(element.department.toString()),
                          value: element.departmentId.toString(),
                        );
                      }).toList(),
                      onChanged: (value) {
                        controller.onChangeDepartment(value.toString());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Obx(
            () => Container(
              margin: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text('Company:'),
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
                      value: controller.dropDownCompany.value,
                      items: controller.listCompany.map((element) {
                        return DropdownMenuItem(
                          child: Text(element.company.toString()),
                          value: element.companyId.toString(),
                        );
                      }).toList(),
                      onChanged: (value) {
                        controller.onChangeCompany(value.toString());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  addButton({required BuildContext context}) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
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
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('New Employee'),
                content: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
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
                      selectedDropdown(),
                      _textInputData(
                          title: 'Name (lao)',
                          onChange: (value) => controller.nameLa.value = value),
                      _textInputData(
                          title: 'Name (eng)',
                          onChange: (value) => controller.nameEn.value = value),
                      _textInputData(
                          title: 'Nick name',
                          onChange: (value) =>
                              controller.nickname.value = value),
                      _textInputData(
                          title: 'Email',
                          onChange: (value) => controller.email.value = value),
                    ],
                  ),
                ),
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
                      controller.addEmployeeData();
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

  _textInputData({String? title, ValueChanged<String>? onChange}) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(),
          ),
          isDense: true,
          labelText: '$title',
        ),
        onChanged: onChange,
      ),
    );
  }

  selectedDropdown() {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: Row(
        children: [
          Obx(
            () => Container(
              margin: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text('Company:'),
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
                      value: controller.selectedCompany.value,
                      items: controller.listCompany.map((element) {
                        return DropdownMenuItem(
                          child: Text(element.company.toString()),
                          value: element.companyId.toString(),
                        );
                      }).toList(),
                      onChanged: (value) {
                        controller.onSelectCompany(value.toString());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Obx(
            () => Container(
              margin: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text('Department:'),
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
                      hint: Text('Department'),
                      value: controller.selectedDepartment.value,
                      items: controller.listDepartment.map((element) {
                        return DropdownMenuItem(
                          child: Text(element.department.toString()),
                          value: element.departmentId.toString(),
                        );
                      }).toList(),
                      onChanged: (value) {
                        controller.onSelectedDepartment(value.toString());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Obx(
            () => Container(
              margin: EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Text('Position:'),
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
                      hint: Text('Position'),
                      value: controller.selectedPosition.value,
                      items: controller.listPosition.map((element) {
                        return DropdownMenuItem(
                          child: Text(element.position.toString()),
                          value: element.positionId.toString(),
                        );
                      }).toList(),
                      onChanged: (value) {
                        controller.onSelectedPosition(value.toString());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
