import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/company_profiles/controllers/company_profile_controller.dart';

class CompanyProfileView extends GetView<CompanyProfileController> {
  @override
  Widget build(BuildContext context) {
    final CompanyProfileController getController =
        Get.put(CompanyProfileController());
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        getController.getDepartment(companyId: delegate.arguments());

        return Scaffold(
          body: Container(
            margin: EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Company Profile',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Image(
                  image: AssetImage('assets/images/kst.png'),
                  width: 100,
                ),
                Divider(),
                Obx((){
                  if (getController.listDepartment.length==0) {
                    return Container(
                      child: Text('No Data'),
                    );
                  }
                  return Column(
                  children: List.generate(getController.listDepartment.length, (index) {
                    return Text(getController.listDepartment[index].department);
                  }),
                );
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}
