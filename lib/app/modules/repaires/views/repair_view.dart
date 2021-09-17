import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/repaires/controllers/repair_controller.dart';
import 'package:kst_inventory/app/routes/app_routes.dart';
import 'package:kst_inventory/models/device.dart';
import 'package:kst_inventory/models/repaie_device.dart';
import 'package:kst_inventory/utils/constants.dart';

import 'components/receive_device_repair.dart';
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Repairing List device',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              TextButton(
                                onPressed: () {
                                  delegate.toNamed(Routes.ADDREPAIR);
                                },
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                      EdgeInsets.only(
                                        left: 20,
                                        top: 20,
                                        bottom: 20,
                                        right: 20,
                                      ),
                                    ),
                                    backgroundColor: MaterialStateProperty.all(
                                        Appearance.appBarColor),
                                    foregroundColor: MaterialStateProperty.all(
                                        Colors.white)),
                                child: Text('Repair device'),
                              ),
                            ],
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
                                  headingTextStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                  columns: getColumn(controller.columnDevice),
                                  rows: getRows(
                                      controller.lisRepairDevice, context),
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

  List<DataRow> getRows(
          RxList<RepairDevice> listDevice, BuildContext context) =>
      listDevice.map(
        (device) {
          int index = listDevice.indexOf(device);
          return DataRow(
            onSelectChanged: (isSelected) {
              controller.getEmployeeByDeviceId(
                  deviceId: device.deviceId.toString());
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  // contentPadding: EdgeInsets.zero,
                  // backgroundColor: Appearance.backGroundColor,
                  // content: ReceiveDevice(),
                  title: Text('Receive device'),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Do you want to receive this device'),
                      TextField(
                        controller: controller.descriptionController,
                        decoration: InputDecoration(
                          hintText: 'Description',
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel')),
                    TextButton(
                        onPressed: () {
                          controller.delRepair(device: device);
                        },
                        child: Text('OK')),
                  ],
                ),
              );
            },
            cells: [
              DataCell(Text('${index + 1}')),
              DataCell(VerticalDivider()),
              DataCell(Text(device.localId.toString())),
              DataCell(VerticalDivider()),
              DataCell(Text(device.devicetype.toString())),
              DataCell(VerticalDivider()),
              DataCell(Text(
                device.statuss == 'Repair'
                    ? 'Repairing'
                    : device.statuss.toString(),
                style: TextStyle(color: Colors.amber),
              )),
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
              DataCell(VerticalDivider()),
              DataCell(Text(device.descriptions.toString())),
              DataCell(VerticalDivider()),
              DataCell(Text(device.repairDate.toString())),
            ],
          );
        },
      ).toList();

  _searchBox() {
    return Card(
      margin: EdgeInsets.only(top: 10, bottom: 20, left: 20),
      child: Container(
        width: 500,
        child: TextField(
          decoration: InputDecoration(
            isDense: true,
            hintText: 'Search...',
            suffixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
