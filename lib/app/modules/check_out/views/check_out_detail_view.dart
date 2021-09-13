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
          Container(
            padding: EdgeInsets.only(left: 20),
            color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Check out Device',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: IconButton(
                    tooltip: 'Close',
                    icon: Icon(
                      Icons.clear,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                )
              ],
            ),
          ),
          showCheckOutID(),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
                'Date:${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}'),
          ),
          _employeeDetail(),
          Divider(),
          titleBox(),
          Divider(),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Obx(
              ()=> Text(
                'Selected: ${controller.device.length} Devices',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Obx(
                  () {
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
                  },
                ),
              ),
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.only(left: 20, top: 20),
            child: Text(
              'Total: ${controller.listDevices.length} Devices',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  showCheckOutID() {
    return Container(
      color: Colors.grey,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(15),
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
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
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
                  hintText: 'Search...',
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
      .map((device) {
        int index=listDevices.indexOf(device);
        return DataRow(
              cells: [
                DataCell(Text('${index+1}')),
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
              ],
              selected: controller.selectedDevice.contains(device),
              onSelectChanged: (isSelected) {
                if (isSelected == true) {
                  controller.selectedDevice.add(device);
                } else {
                  controller.selectedDevice.remove(device);
                }
                controller.onSelected();
              });
      })
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
          Text('Using Device',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Container(
            margin: EdgeInsets.only(left: 20, top: 10),
            child: Obx(() =>
                Text('Total: ${controller.lisUsingByEmployee.length} Devices')),
          ),
        ],
      ),
    );
  }

  _employeeDetail() {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
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
