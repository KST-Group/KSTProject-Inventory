import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kst_inventory/app/modules/orders/controllers/order_controller.dart';
import 'package:kst_inventory/app/routes/app_routes.dart';
import 'package:kst_inventory/models/device.dart';
import 'package:kst_inventory/utils/constants.dart';

import 'add_device_view.dart';

class OrderView extends GetView<OrderController> {
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        return Scaffold(
          backgroundColor: Appearance.backGroundColor,
          body: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order Device',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Card(
                    margin: EdgeInsets.all(20),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _header(),
                          Divider(),
                          _newDeviceButton(context),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              'Currently in stock',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: _listDevice(context),
                            ),
                          ),
                          Divider(),
                          _bottom(),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _header() {
    return Container(
      margin: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            child: Obx(
              () => TextButton(
                onPressed: controller.listCartDevice.length == 0
                    ? null
                    : () {
                        Get.rootDelegate.toNamed(Routes.ORDER_DETAIL(
                            'id=${controller.autoOrderId.value}'));
                      },
                child: Row(
                    children: [
                      Obx(() => Text(controller.listCartDevice.length.toString())),
                      SizedBox(
                        width: 5,
                      ),
                      SvgPicture.asset(
                        'assets/icons/shopping_cart.svg',
                        color: Colors.red,
                      ),
                      Text('Check out'),

                    ],
                  ),
              ),
            ),

          ),
        ],
      ),
    );
  }

  _listDevice(BuildContext context) {
    return Container(
      child: Obx(
        () => DataTable(
          headingTextStyle: TextStyle(fontWeight: FontWeight.bold),
          columns: createColumn(controller.deviceColumns),
          columnSpacing: 30,
          rows: createRow(controller.listDeviceData, context),
        ),
      ),
    );
  }

  _bottom() {
    return Container(
      padding: EdgeInsets.only(right: 50, top: 20, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Obx(
            () {
              double total = 0.0;
              for (int i = 0; i < controller.listCartDevice.length; i++) {
                total +=
                    double.parse(controller.listCartDevice[i].price.toString());
              }
              return Text(
                'Total: ${NumberFormat.decimalPattern().format(total)} LAK',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              );
            },
          ),
        ],
      ),
    );
  }

  List<DataColumn> createColumn(List<String> deviceColumns) =>
      deviceColumns.map((column) => DataColumn(label: Text(column))).toList();

  List<DataRow> createRow(
          RxList<Device> listDeviceData, BuildContext context) =>
      listDeviceData.map((device) {
        int index = listDeviceData.indexOf(device);
        return DataRow(
          cells: [
            DataCell(Text(device.deviceName.toString())),
            DataCell(VerticalDivider()),
            DataCell(Text(device.brand.toString())),
            DataCell(VerticalDivider()),
            DataCell(Text(device.deviceType.toString())),
            DataCell(VerticalDivider()),
            DataCell(Text(device.model.toString())),
            DataCell(VerticalDivider()),
            DataCell(Text(device.cpus.toString())),
            DataCell(VerticalDivider()),
            DataCell(Text(device.ram.toString())),
            DataCell(VerticalDivider()),
            DataCell(Text(device.hardisk.toString())),
            DataCell(VerticalDivider()),
            DataCell(Text(NumberFormat.currency(
              locale: 'lo',
              symbol: 'LAK',
              decimalDigits: 2,
            ).format(double.parse(device.price.toString())))),
            DataCell(VerticalDivider()),
            DataCell(Text('10')),
            DataCell(VerticalDivider()),
            DataCell(
              InkWell(
                child: Text(
                  'Add to order',
                  style: TextStyle(
                      color: Colors.blue, decoration: TextDecoration.underline),
                ),
                onTap: () {
                  controller.addDeviceToCart(
                    data: Device(
                      model: device.model,
                      price: device.price,
                      brand: device.brand,
                      deviceType: device.deviceType,
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }).toList();

  _newDeviceButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 500,
            child: TextField(
              decoration: InputDecoration(
                  isDense: true,
                  labelText: 'Search',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(),
                  )),
            ),
          ),
          Container(
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.green)),
              height: 50,
              child: InkWell(
                child: Row(
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.green,
                    ),
                    Text('New Device')
                  ],
                ),
                onTap: () {
                  // controller.selectedTypeValue = null;
                  // controller.selectedBrandValue = null;

                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        actionsOverflowButtonSpacing: 0,
                        contentPadding: EdgeInsets.zero,
                        backgroundColor: Appearance.backGroundColor,
                        elevation: 0,
                        //actionsPadding: EdgeInsets.only(right: 50, bottom: 20),
                        content: AddDeviceView(),
                        actions: [
                          TextButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black45),
                              foregroundColor: MaterialStateProperty.all(
                                Colors.white,
                              ),
                              padding: MaterialStateProperty.all(
                                EdgeInsets.only(
                                  top: 20,
                                  bottom: 20,
                                  left: 50,
                                  right: 50,
                                ),
                              ),
                            ),
                          ),
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              //Navigator.of(context).pop();
                              //controller.addNewDeviceData();
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Appearance.appBarColor),
                              foregroundColor: MaterialStateProperty.all(
                                Colors.white,
                              ),
                              padding: MaterialStateProperty.all(
                                EdgeInsets.only(
                                  top: 20,
                                  bottom: 20,
                                  left: 50,
                                  right: 50,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
