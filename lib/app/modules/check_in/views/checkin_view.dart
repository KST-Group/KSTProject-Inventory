import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/check_in/controllers/checkin_controller.dart';

class CheckInView extends GetView<CheckInController> {
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
                Text(
                  'Device Check In',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                SizedBox(height: 50,),
                _searchTextBox(),
                SizedBox(height: 20,),
                Divider(),
              ],
            ),
          ),
        );
      },
    );
  }

  _searchTextBox() {
    final border = const OutlineInputBorder(borderSide: BorderSide());
    return Row(
      children: [
        SizedBox(width: 20,),
        Flexible(
          flex: 1,
          child: Container(
            width: 500,
            child: TextField(
              decoration: InputDecoration(
                isDense: true,
                border: border,
                focusedBorder: border,
                hintText: 'Employee ID or Name'
              ),
            ),
          ),
        ),
      ],
    );
  }
}
