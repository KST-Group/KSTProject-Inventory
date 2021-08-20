import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/companys/controllers/company_controller.dart';
import 'package:kst_inventory/app/routes/app_routes.dart';

class CompanyView extends GetView<CompanyController> {
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        return Scaffold(
          body: Container(
            margin: EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Company Profile',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SvgPicture.asset(
                      'assets/icons/company.svg',
                      color: Colors.redAccent,
                      width: 30,
                    ),
                  ],
                ),
                Divider(),
                SizedBox(
                  height: 20,
                ),
                _addButton(context: context),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: _companyCard(context: context),
                )),
              ],
            ),
          ),
        );
      },
    );
  }

  _companyCard({required BuildContext context}) {
    return Obx(
      () {
        if (controller.listCompany.length == 0) {
          return Container(
            child: Text('No data'),
          );
        } else {
          return Column(
            children: List.generate(controller.listCompany.length, (index) {
              return Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 500,
                          child: ListTile(
                            leading: SvgPicture.asset(
                              'assets/icons/company.svg',
                              width: 40,
                              color: Colors.grey,
                            ),
                            title: Text(
                                'Name: ${controller.listCompany[index].company}'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                    'Description: ${controller.listCompany[index].description}'),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    'Address: ${controller.listCompany[index].address}'),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    'Tel: ${controller.listCompany[index].tel}'),
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                _showDialogOption(context, index);
                              },
                            ),
                            onTap: () {
                              Get.rootDelegate.toNamed(Routes.COMPANY_DTAIL(
                                controller.listCompany[index].companyId
                                    .toString(),
                              ));
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 500,
                      child: Divider(),
                    ),
                  ],
                ),
              );
            }),
          );
        }
      },
    );
  }

  _addButton({required BuildContext context}) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.add,
              color: Colors.green,
            ),
            Text('New Company')
          ],
        ),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('New Company'),
              content: Container(
                width: MediaQuery.of(context).size.width / 3,
                padding: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          border: Border.all(),
                        ),
                        child: Icon(Icons.image_not_supported),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Company Name'),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                          hintText: 'Company Name',
                        ),
                        onChanged: (value) {
                          controller.company.value = value;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Company Detail'),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(15),
                        width: 500,
                        height: 200,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        child: TextField(
                          maxLines: null,
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              hintText: 'Description your company'),
                          keyboardType: TextInputType.multiline,
                          onChanged: (value) =>
                              controller.description.value = value,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Address'),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                          hintText: 'Address',
                        ),
                        onChanged: (value) => controller.address.value = value,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('Contact'),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                          hintText: 'Tel',
                        ),
                        onChanged: (value) => controller.tel.value = value,
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel')),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      controller.addCompany();
                    },
                    child: Text('OK'))
              ],
            );
          },
        );
      },
    );
  }

  void _showDialogOption(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Warning'),
          content: Text('Are you sure'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                controller.deleteCompany(
                  companyId: controller.listCompany[index].companyId.toString(),
                );
              },
              child: Text('OK'),
            )
          ],
        );
      },
    );
  }
}
