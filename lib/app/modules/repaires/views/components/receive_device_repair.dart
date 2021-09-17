import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/repaires/controllers/repair_controller.dart';
import 'package:flutter/material.dart';
import 'package:kst_inventory/utils/constants.dart';

class ReceiveDevice extends GetView<RepairController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      child: Column(
        children: [
          Container(
            color: Colors.amber,
            padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Receive device repair',
                  style: TextStyle(color: Colors.white),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.clear,
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  Text('Device ID: 23456789'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
