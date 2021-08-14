import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/dashboard/controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        return Scaffold(
          body: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //LinearProgressIndicator(),
                Text(
                  'Inventory',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      cardItems(
                        title: 'All Devices',
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
                  height: 10,
                ),
                Text(
                  'Currently',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: DataTable(
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
      margin: EdgeInsets.all(15),
      child: Container(
        padding: EdgeInsets.all(10),
        width: 200,
        height: 100,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(8), color: color),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  ico,
                  width: 40,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              data,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
