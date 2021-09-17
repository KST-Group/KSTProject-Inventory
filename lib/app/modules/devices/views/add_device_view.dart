import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kst_inventory/app/modules/devices/controllers/device_controller.dart';
import 'package:kst_inventory/utils/constants.dart';

import 'components/dropdown_brand.dart';
import 'components/dropdown_type.dart';

class AddNewDeviceView extends GetView<DeviceController> {
  const AddNewDeviceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Appearance.backGroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            color: Appearance.appBarColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'New Device',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white),
                ),
                IconButton(
                  tooltip: 'Close',
                  icon: Icon(
                    Icons.clear,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),

          SizedBox(
            height: 20,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: _formInput(context: context),
            ),
          ),
          // _formInput(context: context),
        ],
      ),
    );
  }

  _formInput({required BuildContext context}) {
    return Container(
      margin: EdgeInsets.only(left: 50, right: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [],
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Text('${controller.autoDeviceIdValue.value}'),
                ),
                SizedBox(
                  height: 20,
                ),
                DropDownType(),
                SizedBox(
                  height: 15,
                ),
                DropdownBrand(),
                _textInput(
                  controller: controller.localIDController,
                  title: 'Device ID',
                  hint: 'Local ID',
                  message: 'Custom your device ID',
                ),
                _textInput(
                  controller: controller.deviceNameController,
                  title: 'Device Name',
                  hint: 'Name',
                  message: 'Device name',
                ),
                _textInput(
                  controller: controller.computerNameController,
                  title: 'Computer Name',
                  hint: 'Computer Name',
                  message: 'Provide computer name',
                ),
                _textInput(
                  controller: controller.joinDomainController,
                  title: 'Join Domain',
                  hint: 'Domain Name',
                  message: 'Connect with your organization',
                ),
                _textInput(
                  title: 'Model',
                  hint: 'Device Model',
                  message: 'Input your device model',
                  controller: controller.modelController,
                ),
                _textInput(
                  title: 'Service Tag/SN',
                  hint: 'Service Tag /SN',
                  message: 'Device service tag /SN',
                  controller: controller.serviceTagController,
                ),
                _textInput(
                  title: 'Processor',
                  hint: 'CPU',
                  message: 'Computer CPU',
                  controller: controller.cpuController,
                ),
                _textInput(
                  title: 'Main Memory',
                  hint: 'RAM Size',
                  message: 'Primary Storage',
                  controller: controller.ramController,
                ),
                _textInput(
                  title: 'Storage',
                  hint: 'Hard Disk Size',
                  message: 'Storage your device',
                  controller: controller.hardDiskController,
                ),
                _textInput(
                  title: 'Provider',
                  hint: 'Provider',
                  message: 'Device from provider',
                  controller: controller.providerController,
                ),
                _textInput(
                  title: 'Price',
                  hint: 'LAK',
                  message: 'Cost your device',
                  controller: controller.priceController,
                ),
                SizedBox(
                  height: 20,
                ),
                _textInput(
                  title: 'Comment',
                  hint: 'Comment',
                  message: 'Description your device',
                  controller: controller.commentController,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      width: 150,
                      alignment: Alignment.centerRight,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: Center(
                        child:Container(),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: 175),
                  child: TextButton(
                    onPressed: () {
                      controller.getImageDevice();
                    },
                    child: Text('Choose image'),
                  ),
                ),
                SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _textInput(
      {required String title,
      String? hint,
      String? message,
      TextEditingController? controller}) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: 500,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 180),
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
                margin: EdgeInsets.only(right: 25),
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

  _warranty() {
    return Container(
      width: 400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 150,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Warranty:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            width: 200,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
            ),
            padding: EdgeInsets.all(10),
            child: Center(
              child: DateTimePicker(
                type: DateTimePickerType.date,
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
                dateMask: 'dd/MM/yyyy',
                decoration: InputDecoration(
                  border: UnderlineInputBorder(borderSide: BorderSide.none),
                  hintText: 'Select Date',
                ),
                onChanged: (value) =>
                    controller.warrantyDate = value.toString(),
              ),
            ),
          ),

          // IconButton(onPressed: () {}, icon: Icon(Icons.date_range))
        ],
      ),
    );
  }
}
