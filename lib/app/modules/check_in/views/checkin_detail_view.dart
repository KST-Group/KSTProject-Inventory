import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/check_in/controllers/checkin_controller.dart';
import 'package:flutter/material.dart';
import 'package:kst_inventory/utils/constants.dart';

class CheckInDetailView extends GetView<CheckInController> {
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        return Scaffold(
          body: Container(
            color: Appearance.backGroundColor,
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('CheckIn Device',
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                Expanded(
                  child: Card(
                    margin: EdgeInsets.only(top: 20),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('CHECKIN ID: CHI00001'),
                            ],
                          ),
                          _employeeDetail(),
                          Text('Devices'),
                          Divider(),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Row(
                                children: [
                                  listDeviceDataTable(),
                                  Expanded(child: Container()),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Selected 3 Devices'),
                                TextButton(
                                  child: Text('Check In'),
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                      EdgeInsets.only(
                                        left: 50,
                                        right: 50,
                                        top: 20,
                                        bottom: 20,
                                      ),
                                    ),
                                    backgroundColor: MaterialStateProperty.all(Appearance.appBarColor),
                                    foregroundColor: MaterialStateProperty.all(Colors.white),
                                  ),
                                  onPressed: () {
                                    Get.rootDelegate.popRoute();
                                  },
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
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

  employeeData({required String title, required String data}) {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 100,
            child: Text(
              '$title:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Text(data)
        ],
      ),
    );
  }

  _employeeDetail() {
    return Container(
      padding: EdgeInsets.only(left: 20, top: 20, bottom: 20, right: 500),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      margin: EdgeInsets.only(top: 25, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Employee Data'),
          SizedBox(
            height: 20,
          ),
          employeeData(title: 'EmployeeID', data: 'EMP0001'),
          employeeData(title: 'Name', data: 'Von'),
          employeeData(title: 'Using', data: '3 Devices'),
        ],
      ),
    );
  }

  listDeviceDataTable() {
    return Container(
      child: DataTable(
        columns: _createColumn(),
        rows: _createRows(),
      ),
    );
  }

  List<DataColumn> _createColumn() => controller.columnDevices.map((column) {
        return DataColumn(label: Text(column));
      }).toList();

  List<DataRow> _createRows() => List.generate(20, (index) {
        return DataRow(
          onSelectChanged: (value) {},
          cells: [
            DataCell(Text('Device')),
            DataCell(Text('Device')),
            DataCell(Text('Device')),
            DataCell(Text('Device')),
            DataCell(Text('Device')),
            DataCell(Text('Device')),
            DataCell(Text('Device')),
            DataCell(Text('Device')),
            DataCell(Text('Device')),
            DataCell(Text('Device')),
          ],
        );
      });
}
