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
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: ScrollPhysics(),
                    child: DataTable(
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
                        100,
                        (index) => DataRow(
                          cells: [
                            DataCell(Text('${index + 1}')),
                            DataCell(Text('67897')),
                            DataCell(Text('Laptop')),
                            DataCell(Text('In use')),
                            DataCell(Text('New')),
                            DataCell(Text('Workgroup')),
                            DataCell(Text('ASPIRE E14')),
                            DataCell(Text('24P00')),
                            DataCell(Text('VTP-ICT-012')),
                            DataCell(Text('Computer Name')),
                            DataCell(Text('CORE i5')),
                            DataCell(Text('8GB')),
                            DataCell(Text('8GB')),
                            DataCell(Text('8GB')),
                            DataCell(Text('8GB')),
                            DataCell(Text('8GB')),
                          ],
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
                borderSide: BorderSide(color: Colors.black))),
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
                value: controller.dropdownValue.value,
                onChanged: (String? value) {
                  controller.onChangedValue(value!);
                },
                items: <String>['One', 'Two', 'Tree', 'Four']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
