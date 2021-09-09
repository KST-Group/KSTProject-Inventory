import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kst_inventory/app/modules/devices/controllers/device_controller.dart';
import 'package:kst_inventory/models/device.dart';
import 'package:kst_inventory/utils/constants.dart';

import 'dropdown_brand.dart';
import 'dropdown_type.dart';

class UpdateDeviceView extends GetView<DeviceController> {
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        return Container(
          width: MediaQuery.of(context).size.width / 1.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _appBar(context),
              Expanded(
                child: Obx(
                  () {
                    if (controller.deviceDataById.length == 0) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      Device device = Device();
                      controller.deviceDataById.forEach((data) {
                        device = data;
                      });
                      return Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(

                              child: Text(
                                'Device ID: ${device.deviceId.toString()}',
                              ),
                              margin: EdgeInsets.only(left: 100, top: 20),
                              color: Colors.black12,
                              padding: EdgeInsets.all(10),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: DropDownType(),
                                  width: 300,
                                  margin: EdgeInsets.only(top: 15),
                                ),
                                Container(
                                  child: DropdownBrand(),
                                  width: 300,
                                  margin: EdgeInsets.only(left: 95, top: 15),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: Column(
                                  children: [
                                    _textInput(
                                      title: 'Local ID',
                                      controller: controller.localIDController,
                                      hint: 'Local ID',
                                      message: 'Modify your Local ID',
                                    ),
                                    _textInput(
                                      title: 'Device Name',
                                      controller:
                                          controller.deviceNameController,
                                      hint: 'Device Name',
                                      message: 'Modify your device name',
                                    ),
                                    _textInput(
                                      title: 'Computer Name',
                                      controller:
                                          controller.computerNameController,
                                      hint: 'Computer Name',
                                      message: 'Modify your computer name',
                                    ),
                                    _textInput(
                                      title: 'Model',
                                      controller: controller.modelController,
                                      hint: 'Device Model',
                                      message: 'Change device model',
                                    ),
                                    _textInput(
                                      title: 'Service Tag /SN',
                                      controller:
                                          controller.serviceTagController,
                                      hint: 'Service Tag /SN',
                                      message: 'Modify Service Tag /SN Device',
                                    ),
                                    _textInput(
                                      title: 'CPU',
                                      controller: controller.cpuController,
                                      hint: 'CPU',
                                      message: 'Modify CPU Device',
                                    ),
                                    _textInput(
                                      title: 'RAM',
                                      controller: controller.ramController,
                                      hint: 'RAM Size',
                                      message: 'Modify RAM',
                                    ),
                                    _textInput(
                                      title: 'Hard Disk',
                                      controller: controller.hardDiskController,
                                      hint: 'Hard Disk Size',
                                      message: 'Modify Hard Disk',
                                    ),
                                  ],
                                )),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _textInput(
                                        title: 'Join Domain',
                                        controller:
                                            controller.joinDomainController,
                                        hint: 'Domain Name',
                                        message:
                                            'Connect with your organization',
                                      ),
                                      _textInput(
                                        title: 'Provider',
                                        controller:
                                            controller.providerController,
                                        hint: 'Provider',
                                        message: 'Change your Provider',
                                      ),
                                      _textInput(
                                        title: 'Price',
                                        controller: controller.priceController,
                                        hint: 'Price',
                                        message: 'Change your Price',
                                      ),
                                      _textInput(
                                        title: 'Warranty',
                                        controller: controller.priceController,
                                        hint: 'Warranty',
                                        message: 'Change your Warranty',
                                      ),
                                      _textInput(
                                        title: 'Comment',
                                        controller:
                                            controller.commentController,
                                        hint: 'Comment',
                                        message: 'Change your Comment',
                                      ),
                                      _textInput(
                                        title: 'Remark',
                                        controller: controller.remarkController,
                                        hint: 'Remark',
                                        message: 'Change your Remark',
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _appBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 10),
      color: Colors.amber,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/edit_property.svg',
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Editing Device ',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Close',
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.clear,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

_textInput(
    {required String title,
    String? hint,
    String? message,
    TextEditingController? controller}) {
  return Container(
    margin: EdgeInsets.only(top: 20),
    width: 400,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 160),
          child: Text(
            '$message',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Container(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '$title:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              width: 150,
              margin: EdgeInsets.only(right: 10),
            ),
            Expanded(
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Appearance.appBarColor),
                    ),
                    hoverColor: Colors.white,
                    contentPadding: EdgeInsets.only(
                      left: 10,
                      top: 14,
                      bottom: 14,
                      right: 10,
                    ),
                    hintText: '$hint'),
              ),
            )
          ],
        ),
      ],
    ),
  );
}
