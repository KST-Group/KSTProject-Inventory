import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/devices/controllers/device_controller.dart';
import 'package:kst_inventory/app/routes/app_routes.dart';
import 'package:kst_inventory/models/device.dart';
import 'package:kst_inventory/utils/constants.dart';

import 'components/add_device_view.dart';

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
                child: Card(
                  margin: EdgeInsets.only(top: 20),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        addButtonDevice(context),
                        Divider(),
                        _searchBox(),
                        Expanded(
                          child: _dataTable(),
                        ),
                      ],
                    ),
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
      margin: EdgeInsets.only(top: 20, bottom: 15),
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
                hintText: "ID, Name, Model, Brand ...",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                ),
              ),
              onChanged: (value) {
                controller.searchText.value = value;
                controller.onSearchDevice();
              },
            ),
          ),
          Expanded(
              child: Container(
            child: deviceTypeFilter(),
          )),
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
          child: Obx(
            () {
              if (controller.listDevice.length == 0) {
                return Center(
                  child: Text('No data'),
                );
              }
              if (controller.searchText.value.length > 0 &&
                  controller.listSearch.length == 0) {
                return Center(
                  child: Text('No data'),
                );
              }
              return DataTable(
                headingTextStyle: TextStyle(fontWeight: FontWeight.bold),
                columns: getColumns(),
                rows: getRows(
                  listDevice: controller.searchText.value.toString().length == 0
                      ? controller.listDevice
                      : controller.listSearch,
                ),
                showCheckboxColumn: false,
              );
            },
          ),
        ),
      ),
    );
  }

  addButtonDevice(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(
          'assets/icons/device_manager.svg',
          color: Colors.grey,
          width: 50,
        ),
        Container(
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(border: Border.all(color: Colors.green)),
            height: 50,
            child: InkWell(
              child: Row(
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.green,
                  ),
                  Text('New Device')
                ],
              ),
              onTap: () {
                controller.selectedTypeValue = null;
                controller.selectedBrandValue = null;

                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      actionsOverflowButtonSpacing: 0,
                      contentPadding: EdgeInsets.zero,
                      backgroundColor: Appearance.backGroundColor,
                      elevation: 0,
                      actionsPadding: EdgeInsets.only(right: 50, bottom: 20),
                      content: AddDeviceView(),
                      actions: [
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black45),
                            foregroundColor: MaterialStateProperty.all(
                              Colors.white,
                            ),
                            padding: MaterialStateProperty.all(
                              EdgeInsets.only(
                                top: 20,
                                bottom: 20,
                                left: 50,
                                right: 50,
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            //Navigator.of(context).pop();
                            controller.addNewDeviceData();
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Appearance.appBarColor),
                            foregroundColor: MaterialStateProperty.all(
                              Colors.white,
                            ),
                            padding: MaterialStateProperty.all(
                              EdgeInsets.only(
                                top: 20,
                                bottom: 20,
                                left: 50,
                                right: 50,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
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
          Color? textColor;
          if (row.statuss == 'Empty') {
            textColor = Colors.green;
          } else if (row.statuss == 'Using') {
            textColor = Colors.blue;
          } else if (row.statuss == 'Broken') {
            textColor = Colors.red;
          } else if (row.statuss == 'Fixing') {
            textColor = Colors.amber;
          }
          return DataRow(
            onSelectChanged: (value) {
              controller.getDeviceById(deviceId: row.deviceId.toString());
              Get.rootDelegate.toNamed(
                Routes.DEVICE_DETAIL('di=${row.deviceId.toString()}'),
                arguments: row.deviceId.toString(),
              );
            },
            cells: [
              DataCell(Row(
                children: [
                  Text(
                    row.statuss.toString(),
                    style: TextStyle(color: textColor),
                  ),
                ],
              )),
              DataCell(Text(row.deviceId.toString())),
              DataCell(Text(row.localId.toString())),
              DataCell(Text(row.deviceName.toString())),
              DataCell(Text(row.computername.toString())),
              DataCell(Text(row.deviceType.toString())),
              DataCell(Text(row.brand.toString())),
              DataCell(Text(row.joinDomain.toString())),
              DataCell(Text(row.model.toString())),
              DataCell(Text(row.servicetagSn.toString())),
              DataCell(Text(row.provider.toString())),
              DataCell(Text(row.cpus.toString())),
              DataCell(Text(row.ram.toString())),
              DataCell(Text(row.hardisk.toString())),
              DataCell(Text(row.price.toString())),
              DataCell(Text(row.expireDate.toString())),
              DataCell(Text(row.comments.toString())),
              DataCell(Text(row.remark.toString())),
            ],
          );
        },
      ).toList();
}
