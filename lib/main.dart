import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/app/routes/app_page.dart';
import 'package:url_strategy/url_strategy.dart';

import 'services/auth_service.dart';
import 'services/device_services.dart';
import 'services/prefs_service.dart';
import 'services/user_service.dart';

void main() {
  setPathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'KST Inventory',
      initialBinding: BindingsBuilder(
        () {
          Get.put(AuthService());
          Get.put(PrefsService());
          Get.put(UserServices());
          Get.put(DeviceService());
        },
      ),
      getPages: AppPages.routes,
    );
  }
}
