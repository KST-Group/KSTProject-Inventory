import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/home/controllers/home_controller.dart';
import 'package:kst_inventory/app/modules/root/controllers/root_controller.dart';
import 'package:kst_inventory/app/routes/app_routes.dart';

class MenuBar extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        final currentLocation = currentRoute?.location;
        var currentIndex = 0;
        return Container(
          child: Card(
            child: Container(
              padding: EdgeInsets.all(10),
              width: 300,
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    child: Center(
                      child: Image(
                        image: AssetImage('assets/images/kst.png'),
                        width: 100,
                      ),
                    ),
                  ),
                  menuButton(
                    title: 'Dashboard',
                    ico: 'assets/icons/dashboard_layout.svg',
                    onTap: () {
                      delegate.toNamed(Routes.DASHBOARD);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _title(
                      tile: 'Inventory',
                      ico: 'assets/icons/inventory.svg',
                      iconColor: Colors.blue,
                      textColor: Colors.blue),
                  SizedBox(
                    height: 10,
                  ),
                  menuButton(
                    title: 'Devices',
                    ico: 'assets/icons/multiple_devices.svg',
                    onTap: () {
                      delegate.toNamed(Routes.DEVICE);
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _title(
                    tile: 'Transfer',
                    ico: 'assets/icons/data_transfer.svg',
                    iconColor: Colors.redAccent,
                    textColor: Colors.blue,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  menuButton(
                    ico: 'assets/icons/download.svg',
                    title: 'Check In',
                    onTap: () {
                      delegate.toNamed(Routes.CHECKIN);
                    },
                  ),
                  menuButton(
                    ico: 'assets/icons/upload.svg',
                    title: 'Check Out',
                    onTap: () {},
                  ),
                  _title(
                      tile: 'Organizations',
                      ico: 'assets/icons/company.svg',
                      iconColor: Colors.redAccent,
                      textColor: Colors.blue),


                  menuButton(
                    ico: 'assets/icons/company.svg',
                    title: 'Company Profile',
                    onTap: () {
                      delegate.toNamed(Routes.COMPANY);
                    },
                  ),
                  menuButton(
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  menuButton({String? title, GestureTapCallback? onTap, String? ico}) {
    return ListTile(
      horizontalTitleGap: 1,
      leading: SvgPicture.asset(
        ico!,
        color: Colors.black,
        width: 20,
      ),
      title: Text(
        '$title',
        style: TextStyle(color: Colors.black, fontSize: 18),
      ),
      onTap: onTap,
    );
  }

  _title(
      {required String tile,
      Color? textColor,
      Color? iconColor,
      required String ico}) {
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 20),
      child: Row(
        children: [
          Text(
            '$tile',
            style: TextStyle(color: textColor),
          ),
          SizedBox(
            width: 10,
          ),
          SvgPicture.asset(
            ico,
            width: 18,
            color: iconColor,
          ),
        ],
      ),
    );
  }
}
