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
                               // print(controller.listUsingDeviceData.length);
                                controller.createExcel(data: employeeUsing);
                                },
                              ),
                            ],
                          ),
                          _employeeData(employeeUsing),
                          Text(
                            'List Device',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Divider(),
                          Expanded(
                            child: Container(
                              child: SingleChildScrollView(
                                child: Obx(
                                  () => DataTable(
                                    headingTextStyle:
                                        TextStyle(fontWeight: FontWeight.bold),
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

  _employeeData(UsingEmployee emp) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      margin: EdgeInsets.only(top: 10, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _data(label: 'Employee ID', data: emp.employeeId.toString()),
          _data(label: 'Gender', data: emp.gender.toString()),
          _data(label: 'Name (Lao)', data: emp.nameLa.toString()),
          _data(label: 'Name (Eng)', data: emp.nameEn.toString()),
          _data(label: 'Nickname', data: emp.nickname.toString()),
          _data(label: 'Position', data: emp.position.toString()),
          _data(label: 'Department', data: emp.department.toString()),
          _data(label: 'Company', data: emp.company.toString()),
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
          DataCell(Text(device.localId.toString())),
          DataCell(Text(device.deviceName.toString())),
          DataCell(Text(device.brand.toString())),
          DataCell(Text(device.deviceType.toString())),
          DataCell(Text(device.model.toString())),
          DataCell(Text(device.servicetagSn.toString())),
          DataCell(Text(device.deviceName.toString())),
          DataCell(Text(device.cpus.toString())),
          DataCell(Text(device.ram.toString())),
          DataCell(Text(device.hardisk.toString())),
        ]);
      }).toList();

  _data({required String label, required String data}) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, left: 20),
      child: Row(
        children: [
          Container(
            width: 100,
            child: Text(
              '$label:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.end,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Text('$data'),
        ],
      ),
    );
  }
}
