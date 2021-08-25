import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/companys/controllers/company_controller.dart';

class CompanyDetailView extends GetView<CompanyController> {
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        return Scaffold(
          body: Container(
            padding: EdgeInsets.only(left: 30, top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/company.svg',
                        color: Colors.black,
                        width: 50,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${Get.rootDelegate.arguments()}',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                _searchBox(),
                SizedBox(
                  height: 20,
                ),
                Text('Employees'),
                Divider(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Obx(
                      () => Row(
                        children: [
                          DataTable(
                            columns: [
                              DataColumn(label: Text('No')),
                              DataColumn(label: Text('Gender')),
                              DataColumn(label: Text('Name')),
                            ],
                            rows: List.generate(controller.listEmployee.length, (index) {
                              return DataRow(cells: [
                                DataCell(Text('${index + 1}')),
                                DataCell(Text('Male')),
                                DataCell(Text('Nanthavath')),
                              ]);
                            }),
                          ),
                          Expanded(child: Container()),
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

  _searchBox() {
    return Container();
  }
}
