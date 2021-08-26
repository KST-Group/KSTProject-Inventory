import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:kst_inventory/utils/constants.dart';

class DashboardView extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        return Scaffold(
          body: Container(
            color: Appearance.backGroundColor,
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dashboard',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      cardItems(
                        title: 'Stock',
                        ico: 'assets/icons/multiple_devices.svg',
                        data: '150',
                        color: Colors.red,
                      ),
                      cardItems(
                        title: 'Laptop',
                        ico: 'assets/icons/laptop.svg',
                        data: '100',
                        color: Colors.green,
                      ),
                      cardItems(
                        title: 'Desktop',
                        ico: 'assets/icons/pc.svg',
                        data: '20',
                        color: Colors.blue,
                      ),
                      cardItems(
                        title: 'Mobiles',
                        ico: 'assets/icons/mobile.svg',
                        data: '20',
                        color: Colors.amber,
                      ),
                      cardItems(
                        title: 'Other',
                        ico: 'assets/icons/device_manager.svg',
                        data: '20',
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Card(
                    elevation: 3,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: 20, top: 20, bottom: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [],
                                    ),
                                    DataTable(
                                      columns: [
                                        DataColumn(
                                          label: Text('No'),
                                        ),
                                        DataColumn(
                                          label: Text('Name'),
                                        ),
                                        DataColumn(
                                          label: Text('Device'),
                                        ),
                                        DataColumn(
                                          label: Text('Status'),
                                        )
                                      ],
                                      rows: List.generate(
                                        100,
                                        (index) => DataRow(
                                          cells: [
                                            DataCell(Text('${index + 1}')),
                                            DataCell(Text('Adam Swith')),
                                            DataCell(Text('Computer PC')),
                                            DataCell(Text('In use')),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  cardItems(
      {required String title,
      required String data,
      required String ico,
      Color? color}) {
    return Card(
      elevation: 2,
      child: Container(
        padding: EdgeInsets.all(15),
        width: 350,
        height: 100,
        child: Row(
          children: [
            Container(
              color: color,
              height: 80,
              width: 80,
              padding: EdgeInsets.all(20),
              child: SvgPicture.asset(
                ico,
                width: 20,
                fit: BoxFit.contain,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(data,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
