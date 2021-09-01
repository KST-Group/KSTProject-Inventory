import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/devices/controllers/device_controller.dart';
import 'package:kst_inventory/utils/constants.dart';

import 'dropdown_brand.dart';
import 'dropdown_type.dart';

class AddDeviceView extends GetView<DeviceController> {
  const AddDeviceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
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
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 100,
                        child: Text('Device ID:'),
                      ),
                      Text('${controller.autoDeviceIdValue.value}'),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: DropDownType(),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(child: DropdownBrand()),
              ],
            ),
          ),
          Divider(),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Column(
                    children: [
                      _textInput(
                        title: 'Local ID',
                        hint: 'Local device ID',
                        message: 'Custom your local ID',
                        controller: controller.localIDController,
                      ),
                      _textInput(
                        controller: controller.deviceNameController,
                        title: 'Device Name',
                        hint: 'Name',
                        message: 'Device name',
                      ),
                      _textInput(
                        title: 'Computer Name',
                        hint: 'Computer name',
                        message: 'Provide your computer name',
                        controller: controller.computerNameController,
                      ),
                      _textInput(
                        title: 'Join Domain',
                        hint: 'Domain',
                        message: 'Link with your organization',
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
                        title: 'CPU',
                        hint: 'CPU',
                        message: 'Computer CPU',
                        controller: controller.cpuController,
                      ),
                      _textInput(
                        title: 'RAM',
                        hint: 'RAM Size',
                        message: 'Primary Storage',
                        controller: controller.ramController,
                      ),
                      _textInput(
                        title: 'Hard Disk',
                        hint: 'Hard Disk Size',
                        message: 'Storage your device',
                        controller: controller.hardDiskController,
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
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
                      SizedBox(height: 20,),
                      _warranty(),
                      _textInput(
                        title: 'Comment',
                        hint: 'Comment',
                        message: 'Description your device',
                        controller: controller.commentController,
                      ),
                      _textInput(
                        title: 'Remark',
                        hint: 'Mark',
                        message: 'Optional',
                        controller: controller.remarkController,
                      ),
                    ],
                  ),
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
