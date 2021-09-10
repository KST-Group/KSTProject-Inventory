import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:kst_inventory/utils/constants.dart';

class DeviceViewDashboard extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        return Scaffold(
          backgroundColor: Appearance.backGroundColor,
          body: Container(
            padding: EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Activity',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(),
                          _employeeData(),
                          Divider(),
                          Expanded(
                            child: Container(
                              child: SingleChildScrollView(
                                child: DataTable(
                                  columns: [
                                    DataColumn(label: Text('No')),
                                    DataColumn(label: Text('Name')),
                                  ],
                                  rows: List.generate(
                                    30,
                                    (index) => DataRow(
                                      cells: [
                                        DataCell(Text('${index + 1}')),
                                        DataCell(Text('Name')),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
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

  _employeeData() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Employee Field'),
          Text('Employee ID'),
          Text('Name'),
        ],
      ),
    );
  }
}
