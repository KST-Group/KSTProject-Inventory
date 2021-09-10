import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/check_in/controllers/checkin_controller.dart';
import 'package:flutter/material.dart';
import 'package:kst_inventory/models/device.dart';
import 'package:kst_inventory/models/employee_device.dart';
import 'package:kst_inventory/utils/constants.dart';

class CheckInDetailView extends GetView<CheckInController> {
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        EmployeeDev? employeeDev = delegate.arguments();
        if (employeeDev == null) {
          return CircularProgressIndicator();
        }
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
                      child: Obx(() {
                        if (controller.loading.value == true) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('Loading...')
                                ],
                              ),
                            ],
                          );
                        } else {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                color: Colors.grey,
                                padding: EdgeInsets.all(15),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'CHECKIN ID: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    Obx(
                                      () => Text(
                                        controller.autoCheckInId.value
                                            .toString(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              _employeeDetail(employeeDev),
                              Text('Devices'),
                              Divider(),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Row(
                                    children: [
                                      listDeviceDataTable(),
                                      Expanded(
                                        child: Container(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 50),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Obx(() => Text(
                                        'Selected ${controller.selectedDevice.length} Devices')),
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
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Appearance.appBarColor),
                                        foregroundColor:
                                            MaterialStateProperty.all(
                                                Colors.white),
                                      ),
                                      onPressed: () {
                                        controller.checkInDevice(context);
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                        }
                      }),
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
              textAlign: TextAlign.end,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Text(data)
        ],
      ),
    );
  }

  _employeeDetail(EmployeeDev data) {
    return Container(
      padding: EdgeInsets.only(left: 20, top: 20, bottom: 20, right: 500),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      margin: EdgeInsets.only(top: 25, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Employee'),
          SizedBox(
            height: 20,
          ),
          employeeData(title: 'EmployeeID', data: '${data.employeeId}'),
          employeeData(title: 'Name (Eng)', data: '${data.nameEn}'),
          employeeData(title: 'Name (Lao)', data: '${data.nameLa}'),
          employeeData(title: 'Using', data: '${data.device} Devices'),
        ],
      ),
    );
  }

  listDeviceDataTable() {
    return Container(
      child: Obx(
        () {
          if (controller.listUsingDevice.length == 0) {
            return Text('No Data');
          }
          return DataTable(
            columns: _createColumn(),
            rows: _createRows(),
          );
        },
      ),
    );
  }

  List<DataColumn> _createColumn() => controller.columnDevices.map((column) {
        return DataColumn(label: Text(column));
      }).toList();

  List<DataRow> _createRows() => controller.listUsingDevice
      .map(
        (row) => DataRow(
          selected: controller.selectedDevice.contains(row),
          onSelectChanged: (isSelected) {
            if (isSelected == true) {
              controller.selectedDevice.add(row);
            } else {
              controller.selectedDevice.remove(row);
            }
            controller.onSelectedDeviceCheckIn();
          },
          cells: [
            DataCell(Text(row.deviceId.toString())),
            DataCell(Text(row.localId.toString())),
            DataCell(Text(row.deviceName.toString())),
            DataCell(Text(row.brand.toString())),
            DataCell(Text(row.deviceType.toString())),
            DataCell(Text(row.model.toString())),
            DataCell(Text(row.servicetagSn.toString())),
            DataCell(Text(row.cpus.toString())),
            DataCell(Text(row.ram.toString())),
            DataCell(Text(row.hardisk.toString())),
          ],
        ),
      )
      .toList();
}
