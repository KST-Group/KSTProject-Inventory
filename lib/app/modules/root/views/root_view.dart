import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/home/views/home_view.dart';
import 'package:kst_inventory/app/modules/root/controllers/root_controller.dart';
import 'package:kst_inventory/app/routes/app_routes.dart';
import 'package:kst_inventory/services/auth_service.dart';

import '../../home/views/menu_bar.dart';

class RootView extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        return Scaffold(
          appBar: _appBar(),
          body: GetRouterOutlet.builder(
            builder: (context, delegate, currentRoute) {
              return Row(
                children: [
                  MenuBar(),
                  Expanded(
                    child: Container(
                      child: GetRouterOutlet(
                        initialRoute: Routes.HOME,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  _appBar() {
    return AppBar(
      leading: Container(
        margin: EdgeInsets.only(left: 20),
        child: Image(
          image: AssetImage('assets/images/kst.png'),
          width: 40,
        ),
      ),
      title: Text(
        'KST-Inventory',
        style: TextStyle(color: Colors.black),
      ),
      elevation: 1,
      backgroundColor: Colors.white,
      actions: [
        Container(
          margin: EdgeInsets.only(right: 20),
          child: Row(
            children: [
              Text('Adam', style: TextStyle(color: Colors.black),),
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.transparent,
                child: PopupMenuButton(
                  enabled: true,
                  iconSize: 40,
                  icon: SvgPicture.asset(
                    'assets/icons/user.svg',
                    width: 40,
                    color: Colors.black,
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
                      print('User: ${controller.userPrefs.value}');
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
