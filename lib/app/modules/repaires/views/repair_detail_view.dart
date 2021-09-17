import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/repaires/controllers/repair_controller.dart';
import 'package:flutter/material.dart';
import 'package:kst_inventory/models/device.dart';
import 'package:kst_inventory/models/repairs.dart';
import 'package:kst_inventory/utils/constants.dart';

import 'components/add_device_repair.dart';

class RepairDetail extends GetView<RepairController> {
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
                  'Choose Device Repair',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Expanded(
                  child: Card(
                    margin: EdgeInsets.only(top: 20),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(child: Text('Device data', style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),),
                            alignment: Alignment.centerLeft,),
                          SizedBox(height: 15,),
                          Text('Select device for repair'),
                          Divider(),
                          Expanded(
                            child: Obx(
                                  () =>
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: SingleChildScrollView(
                                      child: DataTable(
                                        showCheckboxColumn: false,
                                        headingTextStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                        columnSpacing: 30,
                                        columns: _getColumn(
                                            controller.columnRepair),
                                        rows: getRows(
                                            controller.listDeviceRepair,
                                            context),
                                      ),
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

  List<DataColumn> _getColumn(List<String> columns) =>
      columns.map((column) => DataColumn(label: Text(column))).toList();

  List<DataRow> getRows(RxList<Device> rows, BuildContext context) =>
      rows.map((row) {
        int index = rows.indexOf(row);
        return DataRow(
            cells: [
              DataCell(Text('${index + 1}')),
              DataCell(VerticalDivider()),
              DataCell(Text(row.localId.toString())),
              DataCell(VerticalDivider()),
              DataCell(Text(row.deviceType.toString())),
              DataCell(VerticalDivider()),
              DataCell(Text(row.statuss.toString())),
              DataCell(VerticalDivider()),
              DataCell(Text(row.joinDomain.toString())),
              DataCell(VerticalDivider()),
              DataCell(Text(row.brand.toString())),
              DataCell(VerticalDivider()),
              DataCell(Text(row.model.toString())),
              DataCell(VerticalDivider()),
              DataCell(Text(row.servicetagSn.toString())),
              DataCell(VerticalDivider()),
              DataCell(Text(row.computername.toString())),
              DataCell(VerticalDivider()),
              DataCell(Text(row.cpus.toString())),
              DataCell(VerticalDivider()),
              DataCell(Text(row.ram.toString())),
              DataCell(VerticalDivider()),
              DataCell(Text(row.hardisk.toString())),
            ],
            onSelectChanged: (isSelected) {
              controller.usingByEmployee(data: row.deviceId.toString());
              showDialog(
                context: context,
                builder: (context) =>
                    AlertDialog(
                      backgroundColor: Appearance.backGroundColor,
                      contentPadding: EdgeInsets.zero,
                      content: AddDeviceRepair(
                        device: row,
                      ),
                      actionsPadding: EdgeInsets.only(right: 15, bottom: 15),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancel')),
                        TextButton(
                            onPressed: () {
                              controller.addRepairData(
                                  deviceId: row.deviceId.toString());
                            },
                            child: Text('OK')),
                      ],
                    ),
              );
            });
      }).toList();
}
