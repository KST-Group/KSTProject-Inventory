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
                  Text('Inventory'),
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
                  Text('Transfer'),
                  menuButton(
                    ico: 'assets/icons/reset.svg',
                    title: 'Check In',
                    onTap: () {
                      delegate.toNamed(Routes.CHECKIN);
                    },
                  ),
                  // menuButton(
                  //   title: 'Check Out',
                  //   onTap: () {},
                  // ),
                  // Text('Order'),
                  // menuButton(
                  //   title: 'Order',
                  //   onTap: () {},
                  // ),
                  // menuButton(
                  //   title: 'Receive',
                  //   onTap: () {},
                  // ),
                  // Text('Repair'),
                  // menuButton(title: 'Repair', onTap: () {}),
                  Text('Settings'),
                  // menuButton(
                  //   title: 'Company',
                  //   onTap: () {},
                  // ),
                  menuButton(
                    title: 'User',
                    ico: 'assets/icons/user.svg',
                    onTap: () {
                      delegate.toNamed(Routes.USER);
                    },
                  ),
                  // Text('Report'),
                  // menuButton(
                  //   title: 'Report',
                  //   onTap: () {},
                  // ),
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
}
