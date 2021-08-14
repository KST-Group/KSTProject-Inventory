import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/check_in/controllers/checkin_controller.dart';

class CheckInView extends GetView<CheckInController> {
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        return Scaffold(
          body: Container(child: Text('CheckIn'),),
        );
      },
    );
  }
}
