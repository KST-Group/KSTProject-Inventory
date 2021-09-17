import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:kst_inventory/app/auths/controllers/auth_controller.dart';
import 'package:kst_inventory/app/routes/app_routes.dart';

class AuthView extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        return GetRouterOutlet(initialRoute: Routes.ROOT);
      },
    );
  }
}
