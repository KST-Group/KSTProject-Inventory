import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/home/controllers/home_controller.dart';
import 'package:kst_inventory/app/modules/root/controllers/root_controller.dart';
import 'package:kst_inventory/app/routes/app_routes.dart';
import 'package:kst_inventory/generated/assets.dart';
import 'package:kst_inventory/utils/constants.dart';

class MenuBar extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        final currentLocation = currentRoute?.location;
        var currentIndex = 0;
        if (currentLocation?.startsWith(Routes.DASHBOARD) == true) {
          currentIndex = 0;
        }
        if (currentLocation?.startsWith(Routes.DEVICE) == true) {
          currentIndex = 1;
        } else if (currentLocation?.startsWith(Routes.CHECKIN) == true) {
          currentIndex = 2;
        } else if (currentLocation?.startsWith(Routes.CHECKOUT) == true) {
          currentIndex = 3;
        } else if (currentLocation?.startsWith(Routes.ORDER) == true) {
          currentIndex = 4;
        } else if (currentLocation?.startsWith(Routes.EMPLOYEE) == true) {
          currentIndex = 5;
        }

        return Container(
          child: Card(
            margin: EdgeInsets.zero,
            child: Container(
              color: Appearance.menuColor,
              //padding: EdgeInsets.all(),
              width: 300,
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 150,
                    child: Stack(
                      children: [
                        Center(
                          child: Container(
                            height: 150,
                            color: Colors.blueGrey,
                          ),
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 35,
                                backgroundColor: Colors.transparent,
                                backgroundImage: AssetImage(
                                  'assets/images/user.png',
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                'Adam Smith',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  ////////Menu

                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        child: Column(
                          children: [
                            menuButton(
                              title: 'Dashboard',
                              ico: 'assets/icons/dashboard_layout.svg',
                              selectedColor: currentIndex == 0
                                  ? Appearance.selectedColor
                                  : null,
                              showSelectedColor:
                                  currentIndex == 0 ? Colors.white : null,
                              onTap: () {
                                delegate.toNamed(Routes.DASHBOARD);
                                print('Index=$currentIndex');
                              },
                            ),
                            _title(
                                tile: 'Inventory',
                                ico: 'assets/icons/inventory.svg'),
                            menuButton(
                              title: 'Devices',
                              ico: 'assets/icons/multiple_devices.svg',
                              selectedColor: currentIndex == 1
                                  ? Appearance.selectedColor
                                  : null,
                              showSelectedColor:
                                  currentIndex == 1 ? Colors.white : null,
                              onTap: () {
                                delegate.toNamed(Routes.DEVICE);
                                print('Index=$currentIndex');
                              },
                            ),

                            ///Transfer
                            _title(
                              tile: 'Transfer',
                              ico: 'assets/icons/data_transfer.svg',
                            ),
                            menuButton(
                              ico: 'assets/icons/addtocart.svg',
                              title: 'Check In',
                              selectedColor: currentIndex == 2
                                  ? Appearance.selectedColor
                                  : null,
                              showSelectedColor:
                                  currentIndex == 2 ? Colors.white : null,
                              onTap: () {
                                delegate.toNamed(Routes.CHECKIN);
                              },
                            ),
                            menuButton(
                              ico: 'assets/icons/upload.svg',
                              title: 'Check Out',
                              selectedColor: currentIndex == 3
                                  ? Appearance.selectedColor
                                  : null,
                              showSelectedColor:
                                  currentIndex == 3 ? Colors.white : null,
                              onTap: () {
                                delegate.toNamed(Routes.CHECKOUT);
                              },
                            ),

                            // ///Order
                            // _title(
                            //   tile: 'Order Device',
                            //   ico: 'assets/icons/maintenance.svg',
                            // ),
                            // menuButton(
                            //   ico: 'assets/icons/maintenance.svg',
                            //   title: 'Order',
                            //   selectedColor: currentIndex == 4
                            //       ? Appearance.selectedColor
                            //       : null,
                            //   showSelectedColor:
                            //       currentIndex == 4 ? Colors.white : null,
                            //   onTap: () {
                            //     delegate.toNamed(Routes.ORDER);
                            //   },
                            // ),
                            // menuButton(
                            //   ico: 'assets/icons/maintenance.svg',
                            //   title: 'Receive',
                            //   onTap: () {
                            //     delegate.toNamed(Routes.COMPANY);
                            //   },
                            // ),

                            ///Repair
                            _title(
                              tile: 'Maintenance',
                              ico: 'assets/icons/maintenance.svg',
                            ),
                            menuButton(
                              ico: 'assets/icons/maintenance.svg',
                              title: 'Repair Device',
                              onTap: () {
                                delegate.toNamed(Routes.COMPANY);
                              },
                            ),

                            _title(
                              tile: 'Organizations',
                              ico: 'assets/icons/company.svg',
                            ),

                            // menuButton(
                            //   ico: 'assets/icons/company.svg',
                            //   title: 'Company Profile',
                            //   onTap: () {
                            //     delegate.toNamed(Routes.COMPANY);
                            //   },
                            // ),
                            // menuButton(
                            //   ico: 'assets/icons/small_business.svg',
                            //   title: 'Departments',
                            //   onTap: () {
                            //     delegate.toNamed(Routes.DEPARTMENT);
                            //   },
                            // ),
                            // menuButton(
                            //   ico: 'assets/icons/bulleted_list.svg',
                            //   title: 'Positions',
                            //   onTap: () {
                            //     delegate.toNamed(Routes.POSITION);
                            //   },
                            // ),
                            menuButton(
                              selectedColor: currentIndex == 5
                                  ? Appearance.selectedColor
                                  : null,
                              showSelectedColor:
                                  currentIndex == 5 ? Colors.white : null,
                              ico: 'assets/icons/employee.svg',
                              title: 'Employees',
                              onTap: () {
                                delegate.toNamed(Routes.EMPLOYEE);
                              },
                            ),
                            //_title(tile: 'Settings'),
                            menuButton(
                              title: 'User',
                              ico: 'assets/icons/user.svg',
                              onTap: () {
                                delegate.toNamed(Routes.USER);
                              },
                            ),
                            _title(
                              tile: 'Reports',
                              ico: 'assets/icons/company.svg',
                            ),
                            menuButton(
                              ico: 'assets/icons/maintenance.svg',
                              title: 'Report Device',
                              onTap: () {
                                delegate.toNamed(Routes.COMPANY);
                              },
                            ),
                            menuButton(
                              ico: 'assets/icons/maintenance.svg',
                              title: 'Report Repair',
                              onTap: () {
                                delegate.toNamed(Routes.COMPANY);
                              },
                            ),
                            menuButton(
                              ico: 'assets/icons/maintenance.svg',
                              title: 'Report Employee',
                              onTap: () {
                                delegate.toNamed(Routes.COMPANY);
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
        );
      },
    );
  }

  menuButton({
    String? title,
    GestureTapCallback? onTap,
    String? ico,
    Color? selectedColor,
    Color? showSelectedColor,
  }) {
    return Container(
      color: selectedColor,
      child: Row(
        children: [
          Container(
            width: 2,
            height: 50,
            color: showSelectedColor,
          ),
          Expanded(
            child: ListTile(
              //contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
              dense: true,
              focusColor: Colors.blue,
              hoverColor: Colors.deepPurple,
              horizontalTitleGap: 1,
              leading: SvgPicture.asset(
                ico!,
                color: Colors.white,
                width: 20,
              ),
              title: Text(
                '$title',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              onTap: onTap,
            ),
          ),
        ],
      ),
    );
  }

  _title({
    required String tile,
    required String ico,
  }) {
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 20, left: 10),
      child: Row(
        children: [
          Text(
            '$tile',
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(
            width: 10,
          ),
          SvgPicture.asset(
            ico,
            width: 18,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
