import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:kst_inventory/models/using_device.dart';
import 'package:kst_inventory/models/using_device_employee.dart';
import 'package:kst_inventory/utils/constants.dart';

class DeviceViewDashboard extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        UsingEmployee? employeeUsing = delegate.arguments();
        if (employeeUsing == null) {
          return CircularProgressIndicator();
        }
        controller.getDeviceUsing(employeeUsing.employeeId.toString());
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                child: SvgPicture.asset(
                                  'assets/icons/print.svg',
                                  width: 30,
                                  color: Colors.black,
                                ),
                                onTap: () {
                                  controller.createExcelWorkbook();
                                },
                              ),
                            ],
                          ),
                          _employeeData(employeeUsing),
                          Text('List Device'),
                          Divider(),
                          Expanded(
                            child: Container(
                              child: SingleChildScrollView(
                                child: Obx(
                                  () => DataTable(
                                    columns:
                                        createColumn(controller.deviceColumn),
                                    rows: createRows(
                                        controller.listUsingDeviceData),
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

  _employeeData(UsingEmployee employeeUsing) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Employee Field'),
          Text('Employee ID : ${employeeUsing.employeeId}'),
          Text('Name'),
        ],
      ),
    );
  }

  List<DataColumn> createColumn(List<String> deviceColumn) => deviceColumn
      .map((column) => DataColumn(label: Text(column.toString())))
      .toList();

  List<DataRow> createRows(RxList<Using> listDevice) =>
      listDevice.map((device) {
        int index = listDevice.indexOf(device);
        return DataRow(cells: [
          DataCell(Text('${index + 1}')),
          DataCell(Text(device.deviceId.toString())),
          DataCell(Text(device.deviceId.toString())),
          DataCell(Text(device.deviceId.toString())),
          DataCell(Text(device.deviceId.toString())),
          DataCell(Text(device.deviceId.toString())),
          DataCell(Text(device.deviceId.toString())),
          DataCell(Text(device.deviceId.toString())),
          DataCell(Text(device.deviceId.toString())),
          DataCell(Text(device.deviceId.toString())),
          DataCell(Text(device.deviceId.toString())),
        ]);
      }).toList();

  void _createExcel() {}
}
