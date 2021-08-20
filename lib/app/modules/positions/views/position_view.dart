import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/positions/controllers/position_controller.dart';
import 'package:kst_inventory/app/routes/app_routes.dart';

class PositionView extends GetView<PositionController> {
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
                      "Positions",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    SvgPicture.asset(
                      'assets/icons/bulleted_list.svg',
                      width: 25,
                      color: Colors.red,
                    ),
                  ],
                ),
                Divider(),
                _addDepartment(context),
                Expanded(
                  child: SingleChildScrollView(
                    child: _positionBody(context),
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
              Text('New Position'),
            ],
          ),
        ),
        onTap: () {
          _showDialogInput(context);
        },
      ),
    );
  }

  _positionBody(BuildContext context) {
    return Container(
      child: Obx(
        () {
          if (controller.listPosition.length == 0) {
            return Text('No data');
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                controller.listPosition.length,
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
                                  'assets/icons/bulleted_list.svg',
                                  width: 40,
                                  color: Colors.grey,
                                ),
                                title: Text(
                                    controller.listPosition[index].position),
                                subtitle: Text(controller
                                        .listPosition[index].description ??
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
                                      Routes.POSITION_DETAIL(controller
                                          .listPosition[index].positionId
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
                controller.deletePosition(
                  positionId:
                      controller.listPosition[index].positionId.toString(),
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
          title: Text('New Position'),
          content: Container(
            width: MediaQuery.of(context).size.width / 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Position name'),
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
                      hintText: 'Position'),
                  onChanged: (value) => controller.position.value = value,
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
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                  child: TextField(
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        isDense: true,
                        hintText: 'Description'),
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
