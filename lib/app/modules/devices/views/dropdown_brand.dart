import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/devices/controllers/device_controller.dart';

class DropdownBrand extends GetView<DeviceController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text('Brand'),
          SizedBox(
            width: 20,
          ),
          Flexible(
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Obx(
                () => DropdownButton<String>(
                  hint: Text('Select brand'),
                  underline: Container(),
                  isExpanded: true,
                  isDense: true,
                  value: controller.dropdownBrand.value,
                  items: controller.listBrand
                      .map<DropdownMenuItem<String>>((data) {
                    return DropdownMenuItem(
                      child: Text(data.brand.toString()),
                      value: data.brandId.toString(),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    controller.onChangeBrand(value!);
                  },
                ),
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
                    title: Text('Brand'),
                    content: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Text('Brand:'),
                                SizedBox(
                                  width: 15,
                                ),
                                Flexible(
                                  flex: 1,
                                  child: TextField(
                                    controller: controller.brand,
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
                          controller.addBrand().then((value) {
                            Navigator.of(context).pop();
                          });
                        },
                        child: Text('OK'),
                      ),
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
        ],
      ),
    );
  }
}
