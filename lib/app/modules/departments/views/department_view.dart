import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/departments/controllers/department_controller.dart';
import 'package:kst_inventory/app/routes/app_routes.dart';

class DepartmentView extends GetView<DepartmentController> {
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
                Row(
                  children: [
                    Text(
                      "Departments",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    SvgPicture.asset(
                      'assets/icons/small_business.svg',
                      width: 25,
                      color: Colors.red,
                    ),
                  ],
                ),
                Divider(),
                _addDepartment(context),
                Expanded(
                  child: SingleChildScrollView(
                    child: _departmentBordy(context),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _addDepartment(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      child: InkWell(
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.add,
                size: 20,
                color: Colors.green,
              ),
              SizedBox(
                width: 10,
              ),
              Text('New Department'),
            ],
          ),
        ),
        onTap: () {
          _showDialogInput(context);
        },
      ),
    );
  }

  _departmentBordy(BuildContext context) {
    return Container(
      child: Obx(
            () {
          if (controller.listDepartment.length == 0) {
            return Text('No data');
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                controller.listDepartment.length,
                    (index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 500,
                              child: ListTile(
                                leading: SvgPicture.asset(
                                  'assets/icons/small_business.svg',
                                  width: 40,
                                  color: Colors.grey,
                                ),
                                title: Text(controller
                                    .listDepartment[index].department),
                                subtitle: Text(controller
                                    .listDepartment[index].description ??
                                    'Description'),
                                trailing: IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    _showDialogOption(context, index);
                                  },
                                ),
                                onTap: () {
                                  Get.rootDelegate.toNamed(
                                      Routes.DEPARTMENT_DETAIL(controller
                                          .listDepartment[index].departmentId
                                          .toString()));
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 500,
                          child: Divider(),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }

  void _showDialogOption(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Warning'),
          content: Text('Are you sure'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                controller.deleteDepart(
                  departId:
                  controller.listDepartment[index].departmentId.toString(),
                );
              },
              child: Text('OK'),
            )
          ],
        );
      },
    );
  }

  void _showDialogInput(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('New Department'),
          content: Container(
            width: MediaQuery
                .of(context)
                .size
                .width / 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Department name'),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      hintText: 'Department'
                  ),
                  onChanged: (value) => controller.department.value = value,
                ),
                SizedBox(
                  height: 20,
                ),
                Text('Description'),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  width: 500,
                  height: 200,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey)
                  ),
                  child: TextField(
                    decoration: InputDecoration(

                        border: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        isDense: true,
                        hintText: 'Description'

                    ),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    onChanged: (value) => controller.description.value = value,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                controller.addData();
              },
              child: Text('OK'),
            )
          ],
        );
      },
    );
  }
}
