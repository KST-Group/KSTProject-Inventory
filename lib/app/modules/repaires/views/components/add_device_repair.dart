import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/repaires/controllers/repair_controller.dart';
import 'package:flutter/material.dart';
import 'package:kst_inventory/utils/constants.dart';

class AddDeviceRepair extends GetView<RepairController> {
  @override
  Widget build(BuildContext context) {
    return Container(
     // width: MediaQuery.of(context).size.width / 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
            color: Appearance.appBarColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Add Device Repair',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                IconButton(
                    tooltip: 'Close',
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.clear,
                      color: Colors.redAccent,
                    ))
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _dataDetail(title: 'Repair ID', data: 'RP1234',color: Colors.white),
                  _dataDetail(title: 'Employee ID', data: 'EMP23456'),
                  _dataDetail(title: 'Device ID', data: 'DV123456',color: Colors.white),
                  _dataDetail(title: 'Status', data: 'Unknown'),
                  _dataDetail(title: 'Device Type', data: 'Type',color: Colors.white),
                  _dataDetail(title: 'Brand', data: 'Brand Device'),
                  _dataDetail(title: 'Model', data: 'Model234',color: Colors.white),
                  _dataDetail(title: 'Buy Date', data: 'Buy'),
                  _dataDetail(title: 'Price', data: '1003983 LAK',color: Colors.white),
                  _dataDetail(title: 'Provider', data: 'Acer'),
                  _dataDetail(title: 'Warranty', data: '01/01/2022',color: Colors.white),
                  _dataDetail(
                      title: 'Repair Date',
                      data:
                          '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}'),
                  SizedBox(height: 10,),
                  Container(

                    padding: EdgeInsets.all(15),
                    width: 500,
                    height: 200,
                    decoration: BoxDecoration(
                      //border: Border.all(color: Colors.grey),
                      color: Colors.white
                    ),
                    child: TextField(
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: 'Description',
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder:  OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        hoverColor: Colors.white,

                      ),
                      keyboardType: TextInputType.multiline,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _dataDetail({required String title, required String data,Color? color}) {
    return Container(
      padding: EdgeInsets.only(top: 10,bottom: 10),
      color: color,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 150,
            child: Text(
              '$title:',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            width: 150,
            child: Text('$data'),
          )
        ],
      ),
    );
  }
}
