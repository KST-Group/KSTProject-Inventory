import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/devices/controllers/device_controller.dart';
import 'package:kst_inventory/app/routes/app_routes.dart';
import 'package:kst_inventory/models/device.dart';
import 'package:kst_inventory/utils/constants.dart';
import 'add_device_view.dart';

class DeviceView extends GetView<DeviceController> {
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        return Container(
          padding: EdgeInsets.all(20),
          color: Appearance.backGroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'All Devices',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Card(
                            elevation: 3,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _searchBox(),
                                Icon(Icons.arrow_drop_down),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                          Card(
                            elevation: 3,
                            child: Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              color: Appearance.appBarColor,
                              height: 42,
                              child: Center(child: addButtonDevice(context)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: Card(
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
                                        height: 15,
                                      ),
                                      Text('Loading...'),
                                    ],
                                  ),
                                ],
                              );
                            } else {
                              return _dataTable();
                            }
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  //deviceType(),
  ///////////////////////////////////////////////////////////////////////////
  _searchBox() {
    return Container(
      child: Row(
        children: [
          Container(
            width: 500,
            child: TextField(
              controller: controller.searchController,
              decoration: InputDecoration(
                isDense: true,
                prefixIcon: Icon(Icons.search),
                suffixIcon: Obx(
                  () => controller.searchText.value.length == 0
                      ? Container(
                          width: 1,
                        )
                      : InkWell(
                          child: Icon(Icons.clear),
                          onTap: () {
                            controller.searchController.clear();
                            controller.searchText.value = '';
                            controller.getDevice();
                          },
                        ),
                ),
                hintText: "Search...",
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                controller.searchText.value = value;
                controller.onSearchDevice();
              },
            ),
          ),
        ],
      ),
    );
  }

  deviceTypeFilter() {
    return Container(
      margin: EdgeInsets.only(left: 15),
      child: Row(
        children: [
          Text(
            'Device Type:',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 10,
          ),
          Container(),
        ],
      ),
    );
  }

  _dataTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Devices',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 15,
                ),
                DataTable(
                  columnSpacing: 35,
                  headingTextStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  headingRowColor:
                      MaterialStateProperty.all(Appearance.backGroundColor),
                  showBottomBorder: true,
                  columns: getColumns(),
                  rows: getRows(
                    listDevice:
                        controller.searchText.value.toString().length == 0
                            ? controller.listDevice
                            : controller.listSearch,
                  ),
                  showCheckboxColumn: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  addButtonDevice(BuildContext context) {
    return Container(
      child: TextButton(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.add,
              color: Colors.white,
            ),
            Text(
              'New Device',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                contentPadding: EdgeInsets.zero,
                content: AddNewDeviceView(),
                actionsPadding: EdgeInsets.only(right: 20, bottom: 20),
                backgroundColor: Appearance.backGroundColor,
                actions: [
                  TextButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      controller.addNewDeviceData(context);
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  List<DataColumn> getColumns() => controller.deviceColumns
      .map(
        (column) => DataColumn(
          label: Text(column),
        ),
      )
      .toList();

  List<DataRow> getRows({required RxList<Device> listDevice}) => listDevice.map(
        (row) {
          int index = listDevice.indexOf(row);
          return DataRow(
            color: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              if (index.isEven) {
                return Colors.grey.withOpacity(0.3);
              }
              return null;
            }),
            onSelectChanged: (value) {
              controller.getDeviceById(deviceId: row.deviceId.toString());
              controller.usingByEmployee(data: row.deviceId.toString());
              Get.rootDelegate.toNamed(
                Routes.DEVICE_DETAIL(row.deviceId.toString()),
              );
            },
            cells: [
              DataCell(Text('${index + 1}')),
              DataCell(VerticalDivider()),
              DataCell(Text(row.localId.toString())),
              DataCell(VerticalDivider()),
              DataCell(Text(row.deviceType.toString())),
              DataCell(VerticalDivider()),
              DataCell(Text(row.comments.toString())),
              DataCell(VerticalDivider()),
              DataCell(Text(row.statuss.toString())),
              DataCell(VerticalDivider()),
              DataCell(Text(
                  row.joinDomain == '' ? 'None' : row.joinDomain.toString())),
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
              DataCell(VerticalDivider()),
              DataCell(Text('Action')),
            ],
          );
        },
      ).toList();
}
