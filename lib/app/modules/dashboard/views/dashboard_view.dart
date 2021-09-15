import 'package:data_table_2/data_table_2.dart';
import 'package:data_table_2/paginated_data_table_2.dart';
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
                _searchBox(),
                Container(
                  child: Obx(() => controller.searchTextValue.value.length != 0
                      ? Container()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Overview',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      InkWell(
                                        child: Text(
                                          'View all devices',
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                        onTap: () {
                                          Get.rootDelegate
                                              .toNamed(Routes.DEVICE);
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Obx(
                                      () => Row(
                                        children: [
                                          cardItems(
                                            title: 'All Device',
                                            ico:
                                                'assets/icons/multiple_devices.svg',
                                            data:
                                                '${controller.listDeviceData.length}',
                                            color: Colors.red,
                                          ),
                                          cardItems(
                                            title: 'In Stock',
                                            ico: 'assets/icons/product.svg',
                                            data:
                                                '${controller.listStockDevice.length}',
                                            color: Colors.amber,
                                          ),
                                          cardItems(
                                            title: 'Laptop',
                                            ico: 'assets/icons/laptop.svg',
                                            data:
                                                '${controller.listLaptopDevice.length}',
                                            color: Colors.green,
                                          ),
                                          cardItems(
                                            title: 'Desktop',
                                            ico: 'assets/icons/pc.svg',
                                            data:
                                                '${controller.listDesktopDevice.length}',
                                            color: Colors.blue,
                                          ),
                                          cardItems(
                                            title: 'Mobiles',
                                            ico: 'assets/icons/mobile.svg',
                                            data:
                                                '${controller.listMobileDevice.length}',
                                            color: Colors.amber,
                                          ),
                                          cardItems(
                                            title: 'Other',
                                            ico:
                                                'assets/icons/device_manager.svg',
                                            data:
                                                '${controller.listDeviceData.length - controller.listMobileDevice.length - controller.listDesktopDevice.length - controller.listLaptopDevice.length}',
                                            color: Colors.blue,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(),
                            Text(
                              'Device Activity',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Obx(
                              () => Row(
                                children: [
                                  _deviceActivity(
                                      title: 'Current In Use',
                                      color: Colors.blue,
                                      data: controller.listUsingDevice.length
                                          .toString(),
                                      icon: 'assets/icons/device_using.svg'),
                                  _deviceActivity(
                                      title: 'Issues',
                                      color: Colors.red.shade900,
                                      data: controller.listIssueDevice.length
                                          .toString(),
                                      icon: 'assets/icons/device_warning.svg'),
                                ],
                              ),
                            ),
                          ],
                        )),
                ),
                Expanded(
                  child: Card(
                    elevation: 3,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Current Activity',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          Divider(),
                          Obx(
                            () {
                              if (controller.searchTextValue.value.isNotEmpty &&
                                  controller.listSearchDeviceData.length == 0) {
                                return Center(
                                  child: Text('No Data'),
                                );
                              }
                              if (controller.listEmployeeUsingDevice.length ==
                                  0) {
                                return Center(
                                  child: Text('No Data'),
                                );
                              }
                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SingleChildScrollView(
                                  child: DataTable(
                                    headingTextStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        fontFamily: 'Inter'),
                                    showCheckboxColumn: false,
                                    columnSpacing: 22,
                                    headingRowColor: MaterialStateProperty.all(
                                        Appearance.backGroundColor),
                                    showBottomBorder: true,
                                    columns: createColumn(),
                                    rows: createRow(
                                        list: controller
                                                    .searchTextValue.value ==
                                                ''
                                            ? controller.listEmployeeUsingDevice
                                            : controller.listSearchDeviceData),
                                  ),
                                ),
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
      child: InkWell(
        child: Container(
          padding: EdgeInsets.all(15),
          width: 300,
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      '$data Device',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DataColumn> createColumn() => controller.columns
      .map((column) => DataColumn(label: Text(column)))
      .toList();

  List<DataRow> createRow({required RxList<UsingEmployee> list}) => list.map(
        (using) {
          int index = list.indexOf(using);
          return DataRow(
            color: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (index.isOdd) {
                  return Colors.grey.withOpacity(0.3);
                }
                return null;
              },
            ),
            onSelectChanged: (isSelected) {
              Get.rootDelegate.toNamed(
                  Routes.DEVICE_VIEW_DASHBOARD(using.employeeId.toString()),
                  arguments: using);
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
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _deviceActivity(
      {required String title,
      required Color color,
      required String data,
      required String icon}) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      child: Card(
        color: color,
        elevation: 3,
        child: Container(
          padding: EdgeInsets.all(10),
          width: 200,
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    '$title',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SvgPicture.asset(
                icon,
                width: 30,
                color: Colors.white,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '$data Devices',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
