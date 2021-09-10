import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RepairView extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        return Scaffold(
          body: Container(
            child: Text('Repair'),
          ),
        );
      },
    );
  }
}
