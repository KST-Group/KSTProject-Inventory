import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:kst_inventory/app/routes/app_routes.dart';
import 'package:kst_inventory/models/using_device_employee.dart';
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
                        title: 'All Device',
                        ico: 'assets/icons/multiple_devices.svg',
                        data: '${controller.listDeviceData.length}',
                        color: Colors.red,
                      ),
                      cardItems(
                        title: 'In Stock',
                        ico: 'assets/icons/multiple_devices.svg',
                        data: '0',
                        color: Colors.red,
                      ),
                      cardItems(
                        title: 'Laptop',
                        ico: 'assets/icons/laptop.svg',
                        data: '${controller.listLaptopDevice.length}',
                        color: Colors.green,
                      ),
                      cardItems(
                        title: 'Desktop',
                        ico: 'assets/icons/pc.svg',
                        data: '${controller.listDesktopDevice.length}',
                        color: Colors.blue,
                      ),
                      cardItems(
                        title: 'Mobiles',
                        ico: 'assets/icons/mobile.svg',
                        data: '${controller.listMobileDevice.length}',
                        color: Colors.amber,
                      ),
                      cardItems(
                        title: 'Other',
                        ico: 'assets/icons/device_manager.svg',
                        data:
                            '${controller.listDeviceData.length - controller.listMobileDevice.length - controller.listDesktopDevice.length - controller.listLaptopDevice.length}',
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
                _searchBox(),
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
                                      children: [
                                        Text(
                                          'Current Activity',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Obx(
                                      () {
                                        return DataTable(
                                          showCheckboxColumn: false,
                                          headingRowColor:
                                              MaterialStateProperty.all(
                                            Appearance.backGroundColor,
                                          ),
                                          columnSpacing: 20,
                                          showBottomBorder: true,
                                          headingTextStyle: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                          columns: createColumn(),
                                          rows: createRow(controller
                                              .listEmployeeUsingDevice),
                                        );
                                      },
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

  List<DataColumn> createColumn() => controller.columns
      .map((column) => DataColumn(label: Text(column)))
      .toList();

  List<DataRow> createRow(RxList<UsingEmployee> list) => list.map(
        (using) {
          int index = list.indexOf(using);
          return DataRow(
            color: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (index.isEven) {
                  return Colors.grey.withOpacity(0.3);
                }
                return null;
              },
            ),
            onSelectChanged: (isSelected) {
              Get.rootDelegate.toNamed(
                  Routes.DEVICE_VIEW_DASHBOARD(using.employeeId.toString()));
            },
            cells: [
              DataCell(Text('${index + 1}')),
              DataCell(VerticalDivider()),
              DataCell(Text(using.employeeId.toString())),
              DataCell(VerticalDivider()),
              DataCell(Text(using.gender.toString())),
              DataCell(VerticalDivider()),
              DataCell(Text(using.nameLa.toString())),
              DataCell(VerticalDivider()),
              DataCell(Text(using.nickname.toString())),
              DataCell(VerticalDivider()),
              DataCell(Text(using.nameEn.toString())),
              DataCell(VerticalDivider()),
              DataCell(Text(using.email.toString())),
              DataCell(VerticalDivider()),
              DataCell(Text(using.position.toString())),
              DataCell(VerticalDivider()),
              DataCell(Text(using.department.toString())),
              DataCell(VerticalDivider()),
              DataCell(Text(using.company.toString())),
              DataCell(VerticalDivider()),
              DataCell(Text('${using.total.toString()} Devices')),
            ],
          );
        },
      ).toList();

  _searchBox() {
    return Container(
      margin: EdgeInsets.only(
        top: 20,
        bottom: 10,
      ),
      child: Card(
        elevation: 3,
        child: Container(
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(0)),
          width: 500,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Search...',
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder:
                        OutlineInputBorder(borderSide: BorderSide.none),
                    suffixIcon: Icon(Icons.search),
                  ),
                  controller: controller.searchTextController,
                  onChanged: (value) {
                    controller.searchTextValue.value = value;
                    controller.onSearchData();
                  },
                ),
              ),
              // DropdownButton(
              //   items: ['1','2','3'],
              //
              // ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
