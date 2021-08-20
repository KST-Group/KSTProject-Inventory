import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/companys/controllers/company_controller.dart';

class CompanyDetailView extends GetView<CompanyController> {
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        return Scaffold(
          body: Container(
            child: Text('Company Detail'),
          ),
        );
      },
    );
  }
}
