import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/devices/controllers/device_controller.dart';
import 'package:kst_inventory/app/modules/devices/views/components/pdf_view.dart';
import 'package:kst_inventory/models/device.dart';
import 'package:kst_inventory/utils/constants.dart';

import 'components/update_device_view.dart';

class DeviceViewDetail extends GetView<DeviceController> {
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        return Scaffold(
          backgroundColor: Appearance.backGroundColor,
          body: Obx(
                () {
              if (controller.deviceDataById.length == 0) {
                return CircularProgressIndicator();
              } else {
                Device device = Device();
                controller.deviceDataById.forEach((element) {
                  device = element;
                });
                return Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //_update(context, device),
                      Text(
                        'About Devices',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Card(
                          margin: EdgeInsets.only(top: 20),
                          child: Container(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Specifications',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          child: Text(
                                            'Update',
                                            style:
                                            TextStyle(color: Colors.amber),
                                          ),
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  contentPadding: EdgeInsets
                                                      .zero,
                                                  elevation: 0,
                                                  backgroundColor: Appearance
                                                      .backGroundColor,
                                                  content: UpdateDeviceView(),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text('Cancel'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text('OK'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  AlertDialog(
                                                    contentPadding: EdgeInsets.zero,
                                                    title: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Text('Preview'),
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                  context)
                                                                  .pop();
                                                            },
                                                            child: Icon(
                                                              Icons.clear,
                                                              color: Colors.red,
                                                            ))
                                                      ],
                                                    ),
                                                    content: PdfView(),
                                                  ),
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              Icon(Icons.print),
                                              Text('Print'),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Divider(),
                                Expanded(
                                  child: Center(
                                    child: Container(
                                      width:
                                      MediaQuery
                                          .of(context)
                                          .size
                                          .width / 2,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            _deviceData(
                                              title: 'Device ID',
                                              data: device.localId.toString(),
                                              color: Appearance.backGroundColor,
                                            ),
                                            _deviceData(
                                              title: 'Device Name',
                                              data:
                                              device.deviceName.toString(),
                                            ),
                                            _deviceData(
                                              title: 'Join Domain',
                                              data:
                                              device.joinDomain.toString(),
                                              color: Appearance.backGroundColor,
                                            ),
                                            _deviceData(
                                              title: 'Status',
                                              data: device.statuss.toString(),
                                            ),
                                            _deviceData(
                                              title: 'Employee',
                                              data:
                                              controller.employeeName.value,
                                              color: Appearance.backGroundColor,
                                            ),
                                            _deviceData(
                                              title: 'Device Type',
                                              data:
                                              device.deviceType.toString(),
                                            ),
                                            _deviceData(
                                              title: 'Brand',
                                              data: device.brand.toString(),
                                              color: Appearance.backGroundColor,
                                            ),
                                            _deviceData(
                                              title: 'Model',
                                              data: device.model.toString(),
                                            ),
                                            _deviceData(
                                              title: 'Service Tag/SN',
                                              data: device.servicetagSn
                                                  .toString(),
                                              color: Appearance.backGroundColor,
                                            ),
                                            _deviceData(
                                              title: 'Processor',
                                              data: device.cpus.toString(),
                                            ),
                                            _deviceData(
                                              title: 'Main Memory',
                                              data: device.ram.toString(),
                                              color: Appearance.backGroundColor,
                                            ),
                                            _deviceData(
                                              title: 'Storage',
                                              data: device.hardisk.toString(),
                                            ),
                                            _deviceData(
                                              title: 'Warranty',
                                              data: device.expireDate ?? '--',
                                              color: Appearance.backGroundColor,
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Text('Image'),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(),
                                              ),
                                              width: 200,
                                              height: 200,
                                              child: Icon(
                                                  Icons.image_not_supported),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }

  _dataDetail({required String title, required String data}) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                child: Row(
                  children: [
                    Container(
                      child: Text(
                        '$title:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.end,
                      ),
                      width: 300,
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Container(
                      width: 300,
                      child: Text(
                        '$data',
                        style: TextStyle(
                            fontSize: 20, color: Appearance.appBarColor),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(),
        ],
      ),
    );
  }

  
  _deviceData({required String title, required String data, Color? color}) {
    return Container(
      color: color,
      padding: EdgeInsets.all(15),
      child: Row(
        children: [
          Container(
            child: Text('$title'),
            width: 200,
          ),
          Text('$data'),
        ],
      ),
    );
  }
}
