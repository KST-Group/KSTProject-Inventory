import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/devices/controllers/device_controller.dart';
import 'package:kst_inventory/utils/constants.dart';

class DropDownType extends GetView<DeviceController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text(
            'Device Type:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Obx(
              () => DropdownButtonFormField(
                menuMaxHeight: 200,
                hint: Text('Select Type'),
                decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    )),
                value: controller.selectedTypeValue,
                items: controller.listType
                    .map(
                      (type) => DropdownMenuItem(
                        child: Text(
                          type.devicetype.toString(),
                        ),
                        value: type.typeId.toString(),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  controller.selectedTypeValue = value.toString();
                },
              ),
            ),
          ),
          IconButton(
            tooltip: 'Add new device type',
            onPressed: () {
              controller.message.value = '';
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: Appearance.backGroundColor,
                  title: Text('New Type'),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Type Name',
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: Colors.white,
                          hoverColor: Colors.white,
                          hintText: 'Device type',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 0.5)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 0.5)),
                        ),
                        onChanged: (value) => controller.newDeviceType = value.toString(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Obx(
                        () => controller.message.value == ''
                            ? Container()
                            : Text(
                                'Message: ${controller.message.value}',
                                style: TextStyle(color: Colors.red),
                              ),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        controller.addDeviceType(context);
                      },
                      child: Text('OK'),
                    )
                  ],
                ),
              );
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
    );
  }
}
