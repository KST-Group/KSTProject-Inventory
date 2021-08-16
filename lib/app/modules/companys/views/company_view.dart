import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompanyView extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        return Scaffold();
      },
    );
  }
}
