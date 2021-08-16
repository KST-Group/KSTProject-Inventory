import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/devices/controllers/device_controller.dart';

import 'add_device_view.dart';

class DeviceView extends GetView<DeviceController> {
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Devices',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('New Device'),
                            content: AddDeviceView(),
                          );
                        },
                      );
                    },
                    child: Text('New'),
                  ),
                ],
              ),
              _searchBox(),
              SizedBox(
                height: 20,
              ),
              Text('Filter'),
              deviceType(),
              SizedBox(
                height: 20,
              ),
              Divider(),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: ScrollPhysics(),
                    child: Obx(
                      () => DataTable(
                        columns: [
                          DataColumn(
                            label: Text('No'),
                          ),
                          DataColumn(
                            label: Text('Device ID'),
                          ),
                          DataColumn(
                            label: Text('Name'),
                          ),
                          DataColumn(
                            label: Text('Type'),
                          ),

                          DataColumn(
                            label: Text('Status'),
                          ),
                          DataColumn(
                            label: Text('Comment'),
                          ),
                          DataColumn(
                            label: Text('Join Domain'),
                          ),
                          DataColumn(
                            label: Text('Model'),
                          ),
                          DataColumn(
                            label: Text('Service Tag SN'),
                          ),
                          DataColumn(
                            label: Text('Local ID'),
                          ),
                          DataColumn(
                            label: Text('Computer Name'),
                          ),
                          DataColumn(
                            label: Text('CPU'),
                          ),
                          DataColumn(
                            label: Text('RAM'),
                          ),
                          DataColumn(
                            label: Text('Hard dist'),
                          ),
                          DataColumn(
                            label: Text('Provider'),
                          ),
                          DataColumn(
                            label: Text('Price'),
                          ),
                          DataColumn(
                            label: Text('Warranty'),
                          ),
                        ],
                        rows: List.generate(
                          controller.listDevice.length,
                          (index) => DataRow(
                            cells: [
                              DataCell(Text('${index + 1}')),
                              DataCell(Text(
                                  '${controller.listDevice[index].deviceId}')),
                              DataCell(Text(
                                  '${controller.listDevice[index].deviceName}')),
                              DataCell(Text(
                                  '${controller.listDevice[index].typeId}')),
                              DataCell(Text(
                                  '${controller.listDevice[index].statuss}')),
                              DataCell(Text(
                                  '${controller.listDevice[index].comments}')),
                              DataCell(Text(
                                  '${controller.listDevice[index].joinDomain}')),
                              DataCell(Text(
                                  '${controller.listDevice[index].model}')),
                              DataCell(Text(
                                  '${controller.listDevice[index].servicetagSn}')),
                              DataCell(Text(
                                  '${controller.listDevice[index].localId}')),
                              DataCell(Text(
                                  '${controller.listDevice[index].computername}')),
                              DataCell(
                                  Text('${controller.listDevice[index].cpus}')),
                              DataCell(
                                  Text('${controller.listDevice[index].ram}')),
                              DataCell(Text(
                                  '${controller.listDevice[index].hardisk}')),
                              DataCell(Text(
                                  '${controller.listDevice[index].provider}')),
                              DataCell(Text(
                                  '${controller.listDevice[index].price}')),
                              DataCell(Text(
                                  '${controller.listDevice[index].warranty}')),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _searchBox() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: 500,
      child: TextField(
        decoration: InputDecoration(
          isDense: true,
          suffixIcon: Icon(Icons.search),
          hintText: "What are you looking for?",
          border: OutlineInputBorder(
            borderSide: BorderSide(),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
        ),
        onChanged: (value) {
          controller.onSearch(value);
        },
        onSubmitted: (value) {
          controller.onSearch(value);
        },
      ),
    );
  }
  deviceType() {
    return Container(
      child: Row(
        children: [
          Text(
            'Device Type:',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(
            width: 10,
          ),
          Obx(
            () => Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5)),
              child: DropdownButton<String>(
                isDense: true,
                hint: Text('Select one'),
                underline: Container(),
                value: controller.filterType.value,
                items: controller.listType.map((value) {
                  return DropdownMenuItem(
                    value: value.typeId.toString(),
                    child: Text(value.deviceType.toString()),
                  );
                }).toList(),
                onChanged: (String? value) {
                  controller.onFilterType(value!);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
