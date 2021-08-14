import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/devices/controllers/device_controller.dart';

class DropDownType extends GetView<DeviceController>{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx((){
        return Row(
          children: [
            Container(
              width: 100,
              child: Text('Device Type:'),
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: DropdownButton<String>(
                  isDense: true,
                  hint: Text('Select device type'),
                  underline: Container(),
                  value: controller.dropdownType.value,
                  items:
                  controller.listType.map<DropdownMenuItem<String>>((data) {
                    return DropdownMenuItem(
                      child: Text(data.deviceType.toString()),
                      value: data.typeId.toString(),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    controller.onChangeType(value!);
                    print('value==$value');
                  },
                ),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(CircleBorder()),
                  padding: MaterialStateProperty.all(EdgeInsets.all(10))),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Device Type'),
                      content: Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Text('Type:'),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: TextField(
                                      controller: controller.deviceType,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
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
                              controller.addDeviceType().then((value) {
                                Navigator.of(context).pop();
                              });
                            },
                            child: Text('OK')),
                      ],
                    );
                  },
                );
              },
              child: SizedBox(
                width: 30,
                child: Icon(Icons.add),
              ),
            ),
            SizedBox(
              width: 20,
            ),
          ],
        );
      }),
    );
  }

}