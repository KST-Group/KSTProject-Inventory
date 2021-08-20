import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/services/position_service.dart';

class PositionDetailView extends GetView<PositionServices> {
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        return Scaffold(
          body: Container(
            child: Text('Position detail'),
          ),
        );
      },
    );
  }
}
