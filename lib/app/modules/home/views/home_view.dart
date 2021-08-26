import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/home/controllers/home_controller.dart';
import 'package:kst_inventory/app/routes/app_routes.dart';
import 'package:kst_inventory/models/user_model.dart';
import 'package:kst_inventory/services/prefs_service.dart';

import '../../root/views/menu_bar.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        return Scaffold(
          body: GetRouterOutlet(
            initialRoute: Routes.CHECKOUT,
            key: Get.nestedKey(Routes.HOME),
          ),
        );
      },
    );
  }
}
