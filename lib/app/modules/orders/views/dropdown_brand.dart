import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/orders/controllers/order_controller.dart';

class DropdownBrand extends GetView<OrderController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        children: [
          Container(
            width: 150,
            child: Text(
              'Brand:',
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.end,
            ),
          ),
          SizedBox(
            width: 25,
          ),
          Obx(
            () => Container(
              width: 300,
              child: DropdownButtonFormField(
                hint: Text('Select Brand'),
                decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    )),
                value: controller.selectedBrandValue,
                items: controller.listBrand
                    .map(
                      (type) => DropdownMenuItem(
                        child: Text(
                          type.brand.toString(),
                        ),
                        value: type.brandId.toString(),
                      ),
                    )
                    .toList(),
                onChanged: (value) =>
                    controller.selectedBrandValue = value.toString(),
              ),
            ),
          ),
          IconButton(
            tooltip: 'Add new brand',
            onPressed: () {
              controller.newBrand.value = '';
              controller.validate.value = false;
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Row(
                      children: [
                        Icon(Icons.add),
                        Text('Brand'),
                      ],
                    ),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('New Brand'),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            hintText: 'Brand name',
                            isDense: true,
                          ),
                          onChanged: (value) =>
                              controller.newBrand.value = value,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Obx(
                          () => controller.validate.value == false
                              ? Container()
                              : Text(
                                  'Input your brand name',
                                  style: TextStyle(color: Colors.red),
                                ),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          controller.addBrand(context);
                        },
                        child: Text('OK'),
                      )
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
    );
  }
}
