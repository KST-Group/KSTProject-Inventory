import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/repaires/controllers/repair_controller.dart';
import 'package:kst_inventory/app/routes/app_routes.dart';
import 'package:kst_inventory/models/device.dart';
import 'package:kst_inventory/utils/constants.dart';

import 'repair_detail_view.dart';

class RepairView extends GetView<RepairController> {
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        return Scaffold(
          backgroundColor: Appearance.backGroundColor,
          body: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Repair Device',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                _searchBox(),
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
                              TextButton(
                                onPressed: () {
                                  delegate.toNamed(Routes.ADDREPAIR);
                                },
                                child: Text('Repair device'),
                              ),
                            ],
                          ),
                          Text(
                            'Repairing List device',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Divider(),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: SingleChildScrollView(
                              child: Obx(
                                () => DataTable(
                                  columnSpacing: 30,
                                  showBottomBorder: true,
                                  showCheckboxColumn: false,
                                  headingTextStyle:
                                      TextStyle(fontWeight: FontWeight.bold),
                                  columns: getColumn(controller.columnDevice),
                                  rows: getRows(controller.listDevice, context),
                                ),
                              ),
                            ),
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

  List<DataColumn> getColumn(List<String> columnDevice) =>
      columnDevice.map((column) => DataColumn(label: Text(column))).toList();

  List<DataRow> getRows(RxList<Device> listDevice, BuildContext context) =>
      listDevice.map(
        (device) {
          int index = listDevice.indexOf(device);
          return DataRow(
            onSelectChanged: (isSelected) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Receive device'),
                ),
              );
            },
            cells: [
              DataCell(Text('${index + 1}')),
              DataCell(VerticalDivider()),
              DataCell(Text(device.localId.toString())),
              DataCell(VerticalDivider()),
              DataCell(Text(device.deviceType.toString())),
              DataCell(VerticalDivider()),
              DataCell(Text(device.statuss.toString())),
              DataCell(VerticalDivider()),
              DataCell(Text(device.joinDomain.toString())),
              DataCell(VerticalDivider()),
              DataCell(Text(device.brand.toString())),
              DataCell(VerticalDivider()),
              DataCell(Text(device.model.toString())),
              DataCell(VerticalDivider()),
              DataCell(Text(device.servicetagSn.toString())),
              DataCell(VerticalDivider()),
              DataCell(Text(device.computername.toString())),
              DataCell(VerticalDivider()),
              DataCell(Text(device.cpus.toString())),
              DataCell(VerticalDivider()),
              DataCell(Text(device.ram.toString())),
              DataCell(VerticalDivider()),
              DataCell(Text(device.hardisk.toString())),
            ],
          );
        },
      ).toList();

  _searchBox() {
    return Card(
      child: Container(
        child: TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide.none)),
        ),
      ),
    );
  }
}
