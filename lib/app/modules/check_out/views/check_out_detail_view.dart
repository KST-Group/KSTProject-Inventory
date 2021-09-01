import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kst_inventory/app/modules/check_out/controllers/check_out_controller.dart';
import 'package:kst_inventory/models/device.dart';
import 'package:kst_inventory/utils/constants.dart';

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
            width: MediaQuery.of(context).size.width,
          ),
          Container(
            child: SingleChildScrollView(
              child: Obx(
                () {
                  if (controller.listDevices.length == 0) {
                    return Container(
                      child: Text('No data'),
                    );
                  } else {
                    return DataTable(
                      dividerThickness: 1,
                      headingRowColor:
                          MaterialStateProperty.all(Colors.grey.shade100),
                      headingTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: Appearance.font_Roboto,
                      ),
                      columnSpacing: 30,
                      columns: getColumn(),
                      rows: getRows(
                        listDevices: controller.searchText.value.length == 0
                            ? controller.listDevices
                            : controller.listSearchDevice,
                      ),
                    );
                  }
                },
              ),
            ),
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20, top: 20),
                child: Text(
                  'Total: ${controller.listDevices.length} Devices',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Obx(() => Padding(
                padding: EdgeInsets.only(top: 20,right: 20),
                child: Text(
                      'Checkout Total: ${controller.device.length} Devices',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
              )),
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

  ///Search Box
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
                controller: controller.searchTextController,
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
                onChanged: (value) {
                  controller.searchText.value = value;
                  controller.onSearchDeviceCheckout();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<DataColumn> getColumn() {
    return controller.columnsDevice
        .map((String column) => DataColumn(label: Text(column)))
        .toList();
  }

  List<DataRow> getRows({required RxList<Device> listDevices}) => listDevices
      .map((device) => DataRow(
              cells: [
                DataCell(Text(device.deviceId.toString())),
                DataCell(VerticalDivider()),
                DataCell(Text(device.localId.toString())),
                DataCell(VerticalDivider()),
                DataCell(Text(device.deviceName.toString())),
                DataCell(VerticalDivider()),
                DataCell(Text(device.deviceType.toString())),
                DataCell(VerticalDivider()),
                DataCell(Text(device.comments.toString())),
                DataCell(VerticalDivider()),
                DataCell(Text(device.model.toString())),
                DataCell(VerticalDivider()),
                DataCell(Text(device.brand.toString())),
                DataCell(VerticalDivider()),
                DataCell(Text(device.cpus.toString())),
                DataCell(VerticalDivider()),
                DataCell(Text(device.ram.toString())),
                DataCell(VerticalDivider()),
                DataCell(Text(device.hardisk.toString())),
                DataCell(VerticalDivider()),
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
