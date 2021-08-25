import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/devices/controllers/device_controller.dart';
import 'package:kst_inventory/app/routes/app_routes.dart';
import 'package:kst_inventory/models/device.dart';

import 'add_device_view.dart';

class DeviceView extends GetView<DeviceController> {
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Devices',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              _searchBox(),
              SizedBox(
                height: 20,
              ),
              Text('Filter'),
              deviceType(),
              SizedBox(
                height: 20,
              ),
              addButtonDevice(context),
              Divider(),
              Expanded(
                child: _dataTable(),
              ),
            ],
          ),
        );
      },
    );
  }

///////////////////////////////////////////////////////////////////////////
  _searchBox() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: 500,
      child: TextField(
        decoration: InputDecoration(
          isDense: true,
          suffixIcon: Icon(Icons.search),
          hintText: "What are you looking for?",
          border: OutlineInputBorder(
            borderSide: BorderSide(),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
        onChanged: (value) {
          controller.onSearch(value);
        },
        onSubmitted: (value) {
          controller.onSearch(value);
        },
      ),
    );
  }

  deviceType() {
    return Container(
      child: Row(
        children: [
          Text(
            'Device Type:',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(
            width: 10,
          ),
          Obx(
            () => Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5)),
              child: DropdownButton<String>(
                isDense: true,
                hint: Text('Select one'),
                underline: Container(),
                value: controller.typeFilter.value,
                items: controller.listType.map((value) {
                  return DropdownMenuItem(
                    value: value.deviceType.toString(),
                    child: Text(value.deviceType.toString()),
                  );
                }).toList(),
                onChanged: (String? value) {
                  controller.typeFilter(value!);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  _dataTable() {
    final columns = [
      'Device ID',
      'Local ID',
      'Device Name',
      'Computer Name',
      'Comment',
      'Join Domain',
      'Model',
      'Service Tag SN',
      'Provider',
      'Device Type',
      'Brand',
      'CPU',
      'RAM',
      'Hard Disk',
      'Price',
      'Warranty',
      'Remark',
      'Status',
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: Container(
          child: Obx(
            () => DataTable(
              headingTextStyle: TextStyle(fontWeight: FontWeight.bold),
              columns: getColumns(columns),
              rows: getRows(controller.listDevice),
              showCheckboxColumn: false,
            ),
          ),
        ),
      ),
    );
  }

  addButtonDevice(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
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
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('New Device'),
                          InkWell(
                            child: Text(
                              'Close',
                              style: TextStyle(fontSize: 16, color: Colors.red),
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                      content: AddDeviceView(),
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

  List<DataColumn> getColumns(List<String> columns) =>
      columns.map((column) => DataColumn(label: Text(column))).toList();

  List<DataRow> getRows(RxList<Device> listDevice) => listDevice
      .map(
        (row) => DataRow(cells: [
          DataCell(Text(row.deviceId.toString())),
          DataCell(Text(row.localId.toString())),
          DataCell(Text(row.deviceName.toString())),
          DataCell(Text(row.computername.toString())),
          DataCell(Text(row.comments.toString())),
          DataCell(Text(row.joinDomain.toString())),
          DataCell(Text(row.model.toString())),
          DataCell(Text(row.servicetagSn.toString())),
          DataCell(Text(row.provider.toString())),
          DataCell(Text(row.deviceType.toString())),
          DataCell(Text(row.brand.toString())),
          DataCell(Text(row.cpus.toString())),
          DataCell(Text(row.ram.toString())),
          DataCell(Text(row.hardisk.toString())),
          DataCell(Text(row.price.toString())),
          DataCell(Text(row.expireDate.toString())),
          DataCell(Text(row.remark.toString())),
          DataCell(Text(row.statuss.toString())),

        ]),
      )
      .toList();
}
