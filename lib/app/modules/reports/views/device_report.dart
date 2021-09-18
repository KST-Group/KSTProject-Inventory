import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:kst_inventory/app/modules/reports/controllers/report_controller.dart';
import 'package:kst_inventory/models/report_devices.dart';
import 'package:kst_inventory/utils/constants.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ReportDevice extends GetView<ReportController> {
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        return Scaffold(
          backgroundColor: Appearance.backGroundColor,
          body: Container(
            padding: EdgeInsets.all(20),
            color: Appearance.backGroundColor,
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/report_file.svg',
                              width: 30,
                              color: Colors.redAccent,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              'Report Devices',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Container(
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/icons/microsoft_excel.svg',
                                width: 30,
                                color: Colors.green,
                              ),
                              Text('Export'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),

                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SingleChildScrollView(
                            child: Obx(
                              () => DataTable(
                                headingTextStyle: TextStyle(fontWeight: FontWeight.bold),
                                showBottomBorder: false,
                                columns: getColumn(
                                    listColumn: controller.columnData),
                                rows: getRows(
                                  listReportDevice: controller.listReportDevice,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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

  getColumn({required List<String> listColumn}) =>
      listColumn.map((columns) => DataColumn(label: Text(columns))).toList();

  List<DataRow> getRows(
          {required RxList<ReportDeviceModel> listReportDevice}) =>
      listReportDevice.map((device) {
        int index = listReportDevice.indexOf(device);
        return DataRow(cells: [
          DataCell(Text('${index + 1}')),
          DataCell(Text('${device.localId}')),
          DataCell(Text('${device.deviceName}')),
          DataCell(Text('${device.computername}')),
          DataCell(Text('${device.statuss}')),
          DataCell(Text('${device.devicetype}')),
          DataCell(Text('${device.brand}')),
          DataCell(Text('${device.model}')),
          DataCell(Text('${device.servicetagSn}')),
          DataCell(Text('${device.cpus}')),
          DataCell(Text('${device.ram}')),
          DataCell(Text('${device.hardisk}')),
          DataCell(Text('${device.provider}')),
          DataCell(Text('${device.buyDate}')),
          DataCell(Text('${device.price}')),
          DataCell(Text('${device.expireDate}')),
          DataCell(Text('${device.comments}')),
        ]);
      }).toList();
}
