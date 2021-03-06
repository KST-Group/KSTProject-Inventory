import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/home/views/home_view.dart';
import 'package:kst_inventory/app/modules/root/controllers/root_controller.dart';
import 'package:kst_inventory/app/routes/app_routes.dart';
import 'package:kst_inventory/services/auth_service.dart';
import 'package:kst_inventory/utils/constants.dart';

import 'menu_bar.dart';

final String username = 'admin';

///login?then=%2F
class RootView extends GetView<RootController> {
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        print(currentRoute!.location);
        return Scaffold(
          appBar: currentRoute.location == '/login?then=%2F' ? null : _appBar(),
          body: Row(
            children: [
              Container(
                child: currentRoute.location == '/login?then=%2F'
                    ? null
                    : MenuBar(),
              ),
              Expanded(
                child: Container(
                  child: GetRouterOutlet(
                    initialRoute: Routes.HOME,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _appBar() {
    return AppBar(
      backgroundColor: Appearance.appBarColor,
      leading: Container(
        margin: EdgeInsets.only(left: 20),
        child: Image(
          image: AssetImage('assets/images/kst.png'),
          width: 40,
        ),
      ),
      title: Text(
        'KST-Inventory',
        style: TextStyle(color: Colors.white),
      ),
      elevation: 2,
      actions: [
        Container(
          margin: EdgeInsets.only(right: 20),
          child: Row(
            children: [
              Text(
                'Adam',
                style: TextStyle(color: Colors.white),
              ),
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.transparent,
                child: PopupMenuButton(
                  enabled: true,
                  iconSize: 40,
                  icon: SvgPicture.asset(
                    'assets/icons/user.svg',
                    width: 40,
                    color: Colors.white,
                  ),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/account.svg',
                              color: Colors.black,
                              width: 20,
                            ),
                            Text('Profile'),
                          ],
                        ),
                        value: 1,
                      ),
                      PopupMenuItem(
                        child: Text('Log out'),
                        value: 2,
                      ),
                    ];
                  },
                  offset: Offset(-20, 50),
                  onSelected: (value) {
                    if (value == 1) {
                      print('User: Admin');
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
