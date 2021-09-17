import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/app/routes/app_page.dart';
import 'package:kst_inventory/services/repair_services.dart';
import 'package:kst_inventory/utils/constants.dart';
import 'package:url_strategy/url_strategy.dart';

import 'services/auth_service.dart';
import 'services/checkin_services.dart';
import 'services/checkout_services.dart';
import 'services/company_services.dart';
import 'services/department_services.dart';
import 'services/device_services.dart';
import 'services/employee_services.dart';
import 'services/order_services.dart';
import 'services/position_service.dart';
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
      theme: ThemeData(
        fontFamily: Appearance.font_Roboto,
      ),
      debugShowCheckedModeBanner: false,
      title: 'KST Inventory',
      initialBinding: BindingsBuilder(
        () {
          Get.put(AuthService());
          Get.put(PrefsService());
          Get.put(UserServices());
          Get.put(DeviceService());
          Get.put(CompanyService());
          Get.put(DepartmentServices());
          Get.put(PositionServices());
          Get.put(EmployeeServices());
          Get.put(CheckoutServices());
          Get.put(CheckInServices());
          Get.put(OrderService());
          Get.put(RepairServices());
        },
      ),
      getPages: AppPages.routes,
    );
  }
}
