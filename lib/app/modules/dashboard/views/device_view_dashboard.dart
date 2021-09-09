import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:kst_inventory/utils/constants.dart';

class DeviceViewDashboard extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        return Scaffold(
          backgroundColor: Appearance.backGroundColor,
          body: Container(
            padding: EdgeInsets.all(25),
            child: Column(
              children: [
                Text('Data')
              ],
            ),
          ),
        );
      },
    );
  }
}
