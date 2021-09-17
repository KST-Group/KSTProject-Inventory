import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/repaires/controllers/repair_controller.dart';
import 'package:flutter/material.dart';
import 'package:kst_inventory/models/device.dart';
import 'package:kst_inventory/utils/constants.dart';

class AddDeviceRepair extends GetView<RepairController> {
  final Device device;

  AddDeviceRepair({required this.device});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width / 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            color: Appearance.appBarColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Add Device Repair',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                IconButton(
                    tooltip: 'Close',
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.clear,
                      color: Colors.redAccent,
                    ))
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(
                    () => _dataDetail(
                        title: 'Repair ID',
                        data: '${controller.repairId}',
                        color: Colors.white),
                  ),
                  Obx(
                    () => _dataDetail(
                        title: 'Employee ID',
                        data: '${controller.employee.value}'),
                  ),
                  _dataDetail(
                      title: 'Device ID',
                      data: '${device.localId}',
                      color: Colors.white),
                  _dataDetail(title: 'Status', data: '${device.statuss}'),
                  _dataDetail(
                      title: 'Device Type',
                      data: '${device.deviceType}',
                      color: Colors.white),
                  _dataDetail(title: 'Brand', data: '${device.brand}'),
                  _dataDetail(
                      title: 'Model',
                      data: '${device.model}',
                      color: Colors.white),
                  _dataDetail(title: 'Buy Date', data: device.buy_date ?? '-'),
                  _dataDetail(
                      title: 'Price',
                      data: device.price == '' ? '-' : device.price.toString(),
                      color: Colors.white),
                  _dataDetail(title: 'Provider', data: '${device.provider}'),
                  _dataDetail(
                      title: 'Warranty',
                      data: device.expireDate ?? '-',
                      color: Colors.white),
                  _dataDetail(
                      title: 'Repair Date',
                      data:
                          '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}'),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    width: 500,
                    height: 200,
                    decoration: BoxDecoration(
                        //border: Border.all(color: Colors.grey),
                        color: Colors.white),
                    child: TextField(
                      controller: controller.descriptions,
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: 'Description',
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        hoverColor: Colors.white,
                      ),
                      keyboardType: TextInputType.multiline,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _dataDetail({required String title, required String data, Color? color}) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      color: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 150,
            child: Text(
              '$title:',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            width: 150,
            child: Text('$data'),
          )
        ],
      ),
    );
  }
}
