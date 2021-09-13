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
          width: 600,
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

                      controller.localIDController.text =
                          device.localId.toString();
                      controller.computerNameController.text =
                          device.computername.toString();
                      controller.deviceNameController.text =
                          device.deviceName.toString();
                      controller.modelController.text = device.model.toString();
                      controller.serviceTagController.text =
                          device.servicetagSn.toString();
                      controller.cpuController.text = device.cpus.toString();
                      controller.ramController.text = device.ram.toString();
                      controller.hardDiskController.text =
                          device.hardisk.toString();
                      controller.joinDomainController.text =
                          device.joinDomain.toString();
                      controller.providerController.text =
                          device.provider.toString();
                      controller.priceController.text = device.price.toString();
                      controller.commentController.text =
                          device.comments.toString();
                      controller.remarkController.text =
                          device.remark.toString();

                      return Container(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: DropDownType(),
                                margin: EdgeInsets.only(top: 10, bottom: 10),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10, bottom: 10),
                                child: DropdownBrand(),
                              ),
                              _textInput(
                                title: 'Local ID',
                                controller: controller.localIDController,
                                hint: 'Local ID',
                                message: 'Modify your Local ID',
                              ),
                              _textInput(
                                title: 'Device Name',
                                controller: controller.deviceNameController,
                                hint: 'Device Name',
                                message: 'Modify your device name',
                              ),
                              _textInput(
                                title: 'Computer Name',
                                controller: controller.computerNameController,
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
                                controller: controller.serviceTagController,
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
                              _textInput(
                                title: 'Join Domain',
                                controller: controller.joinDomainController,
                                hint: 'Domain Name',
                                message: 'Connect with your organization',
                              ),
                              _textInput(
                                title: 'Provider',
                                controller: controller.providerController,
                                hint: 'Provider',
                                message: 'Change your Provider',
                              ),
                              _textInput(
                                title: 'Price',
                                controller: controller.priceController,
                                hint: 'Price',
                                message: 'Change your Price',
                              ),
                              // _textInput(
                              //   title: 'Warranty',
                              //   controller: controller.priceController,
                              //   hint: 'Warranty',
                              //   message: 'Change your Warranty',
                              // ),
                              _textInput(
                                title: 'Comment',
                                controller: controller.commentController,
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
              color: Colors.red,
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
    margin: EdgeInsets.only(top: 20, right: 20),
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
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
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
