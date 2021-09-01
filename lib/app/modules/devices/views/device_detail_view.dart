import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/devices/controllers/device_controller.dart';
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
                      Expanded(
                        child: Card(
                          child: Container(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              children: [
                                _navigation(
                                    context, device.deviceId.toString()),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          // decoration: BoxDecoration(
                                          //   border: Border.all()
                                          // ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('Device Detail',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              _dataDetail(
                                                title: 'Device ID',
                                                data:
                                                    device.deviceId.toString(),
                                              ),
                                              _dataDetail(
                                                title: 'Local ID',
                                                data: device.localId.toString(),
                                              ),
                                              _dataDetail(
                                                title: 'Device Name',
                                                data: device.deviceName
                                                    .toString(),
                                              ),
                                              _dataDetail(
                                                title: 'Computer Name',
                                                data: device.computername
                                                    .toString(),
                                              ),
                                              _dataDetail(
                                                title: 'Device Type',
                                                data: device.deviceType
                                                    .toString(),
                                              ),
                                              _dataDetail(
                                                title: 'Brand',
                                                data: device.brand.toString(),
                                              ),
                                              _dataDetail(
                                                title: 'Status',
                                                data: device.statuss.toString(),
                                              ),
                                              _dataDetail(
                                                title: 'Join Domain',
                                                data: device.joinDomain
                                                    .toString(),
                                              ),
                                              _dataDetail(
                                                title: 'Model',
                                                data: device.model.toString(),
                                              ),
                                              _dataDetail(
                                                title: 'Service Tag /SN',
                                                data: device.servicetagSn
                                                    .toString(),
                                              ),
                                              _dataDetail(
                                                title: 'CPU',
                                                data: device.cpus.toString(),
                                              ),
                                              _dataDetail(
                                                title: 'RAM',
                                                data: device.ram.toString(),
                                              ),
                                              _dataDetail(
                                                title: 'Hard Disk',
                                                data: device.hardisk.toString(),
                                              ),
                                              // _bottom(),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 50,
                                      ),
                                      Expanded(
                                          child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Other',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            _dataDetail(
                                              title: 'Provider',
                                              data: device.provider.toString(),
                                            ),
                                            _dataDetail(
                                              title: 'Price',
                                              data: device.price.toString(),
                                            ),
                                            _dataDetail(
                                              title: 'Warrant',
                                              data:
                                                  device.expireDate.toString(),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(20),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [],
                                                  ),
                                                  Text(
                                                    'Using data',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  _dataDetail(
                                                    title: 'Use by',
                                                    data: device.statuss ==
                                                            'Using'
                                                        ? 'Employee'
                                                        : 'Empty',
                                                  ),
                                                  _dataDetail(
                                                    title: 'Comment',
                                                    data: device.comments
                                                        .toString(),
                                                  ),
                                                  _dataDetail(
                                                    title: 'Remark',
                                                    data: device.remark
                                                        .toString(),
                                                  ),
                                                  // Text(device.comments.toString()),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                    ],
                                  ),
                                ),
                                _bottom(context, device)
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
                      width: 200,
                    ),
                    SizedBox(
                      width: 18,
                    ),
                    Text(
                      '$data',
                      style: TextStyle(
                          fontSize: 20, color: Appearance.appBarColor),
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

  _navigation(BuildContext context, String deviceId) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            tooltip: 'Delete this device',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Row(
                      children: [
                        Text('Warning!!'),
                        Icon(
                          Icons.warning,
                          color: Colors.red,
                        ),
                      ],
                    ),
                    content: Text('Do you want to delete this device?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          controller.deleteDeviceById(deviceId: deviceId);
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }

  _bottom(BuildContext context, Device device) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            child: SvgPicture.asset(
              'assets/icons/edit_property.svg',
              color: Colors.amber,
            ),
            onTap: () {
              controller.localIDController.text = device.localId.toString();
              controller.deviceNameController.text =
                  device.deviceName.toString();
              controller.computerNameController.text =
                  device.computername.toString();

              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    contentPadding: EdgeInsets.zero,
                    elevation: 0,
                    backgroundColor: Appearance.backGroundColor,
                    content: UpdateDeviceView(),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
