import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/devices/controllers/device_controller.dart';

import 'dropdown_brand.dart';
import 'dropdown_type.dart';

class AddDeviceView extends GetView<DeviceController> {
  const AddDeviceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 200,
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _formInput(context: context),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                TextButton(onPressed: () {}, child: Text('OK')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _formInput({required BuildContext context}) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Row(
              children: [
                Container(
                  width: 100,
                  child: Text('Device ID'),
                ),
                Flexible(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text('DV0011'),
                    decoration: BoxDecoration(
                      color: Colors.white12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _dropDownItems(context: context),
                  SizedBox(
                    height: 20,
                  ),
                  _textInput(title: 'Name'),
                  _textInput(title: 'Status'),
                  _textInput(title: 'Comment'),
                  _textInput(title: 'Join Domain'),
                  Text('Device Detail'),
                  _textInput(title: 'Model'),
                  _textInput(title: 'Service Tag / SN'),
                  _textInput(title: 'Local ID'),
                  _textInput(title: 'Computer Name'),
                ],
              )),
              Divider(),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(''),
                  _textInput(title: 'CPU'),
                  _textInput(title: 'RAM'),
                  _textInput(title: 'Hard Disk'),
                  _textInput(title: 'Provider'),
                  _textInput(title: 'Provider'),
                  _textInput(title: 'Price'),
                  Text('Warranty'),
                  _textInput(title: 'Date'),
                ],
              ))
            ],
          ),
        ],
      ),
    );
  }

  _textInput({required String title}) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Container(
              width: 100,
              child: Text('$title:'),
            ),
            flex: 2,
          ),
          Flexible(
            flex: 1,
            child: Container(
              child: TextField(
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                  contentPadding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 15,
                    bottom: 15,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _dropDownItems({required BuildContext context}) {
    return Row(
      children: [
        Flexible(
          flex: 1,
          child: DropDownType(),
        ),
        Flexible(
          flex: 1,
          child: DropdownBrand(),
        ),
      ],
    );
  }
}
