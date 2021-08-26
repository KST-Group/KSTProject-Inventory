import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kst_inventory/app/modules/check_out/controllers/check_out_controller.dart';
import 'package:kst_inventory/models/device.dart';

class CheckOutDetailView extends GetView<CheckOutController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(),
          showCheckOutID(),
          _employeeDetail(),
          titleBox(),
          Divider(),
          Container(
            child: SingleChildScrollView(
              child: Obx(
                () => DataTable(
                  columns: getColumn(),
                  rows: getRows(controller.listDevices),
                ),
              ),
            ),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Device Total: ${controller.listDevices.length}'),
              Obx(() => Text('Checkout Total: ${controller.device.length}')),
            ],
          ),
        ],
      ),
    );
  }

  showCheckOutID() {
    return Container(
      color: Colors.grey,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('CheckOut ID:'),
          SizedBox(
            width: 10,
          ),
          Obx(() => Text('${controller.checkOutAutoId.value}')),
        ],
      ),
    );
  }

  titleBox() {
    return Container(
      margin: EdgeInsets.only(top: 15, bottom: 10),
      child: Row(
        children: [
          Text('Available Devices'),
          SizedBox(
            width: 500,
            child: Container(
              margin: EdgeInsets.only(left: 20),
              child: TextField(
                decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  hintText: 'DeviceID, Name, Brand...',
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<DataColumn> getColumn() {
    final columns = [
      'DeviceID',
      'LocalID',
      'Device Name',
      'Device Type',
      'Comment',
      'Model',
      'brand',
      'CPU',
      'RAM',
      'Hard Disk',
      'Status'
    ];
    return columns
        .map((String column) => DataColumn(label: Text(column)))
        .toList();
  }

  List<DataRow> getRows(RxList<Device> listDevices) => listDevices
      .map((device) => DataRow(
              cells: [
                DataCell(Text(device.deviceId.toString())),
                DataCell(Text(device.localId.toString())),
                DataCell(Text(device.deviceName.toString())),
                DataCell(Text(device.deviceType.toString())),
                DataCell(Text(device.comments.toString())),
                DataCell(Text(device.model.toString())),
                DataCell(Text(device.brand.toString())),
                DataCell(Text(device.cpus.toString())),
                DataCell(Text(device.ram.toString())),
                DataCell(Text(device.hardisk.toString())),
                DataCell(Text(device.statuss.toString())),
              ],
              selected: controller.selectedDevice.contains(device),
              onSelectChanged: (isSelected) {
                if (isSelected == true) {
                  controller.selectedDevice.add(device);
                } else {
                  controller.selectedDevice.remove(device);
                }
                controller.onSelected();
              }))
      .toList();

  _dataDetail({required String title, required String data}) {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 20),
      child: Row(
        children: [
          Container(
            width: 200,
            child: Text(
              '$title:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(data),
        ],
      ),
    );
  }

  checkEmployeeUseDevice() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Using',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Container(
            margin: EdgeInsets.only(left: 20, top: 10),
            child: Text('Total: 3 Devices'),
          ),
        ],
      ),
    );
  }

  _employeeDetail() {
    return Container(
      margin: EdgeInsets.only(right: 20),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Employee Detail',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              _dataDetail(
                  title: 'EmployeeID',
                  data: controller.employeeData.employeeId.toString()),
              _dataDetail(
                title: 'Name',
                data: controller.employeeData.nameEn.toString(),
              ),
              _dataDetail(
                title: 'Company',
                data: controller.employeeData.company.toString(),
              ),
              _dataDetail(
                title: 'Department',
                data: controller.employeeData.department.toString(),
              ),
              _dataDetail(
                title: 'Position',
                data: controller.employeeData.position.toString(),
              ),
            ],
          ),
          Container(
            child: checkEmployeeUseDevice(),
          ),
        ],
      ),
    );
  }
}
