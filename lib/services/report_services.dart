import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:kst_inventory/app/middleware/http_value.dart';
import 'package:kst_inventory/models/report_devices.dart';
import 'package:http/http.dart'as http;

class ReportService extends GetxService{
  static ReportService get to=>Get.find();

  Future<ReportDevices>getReportDevice()async{
    try{
      final response=await http.get(addReportUrl);
      if(response.statusCode==200){
        return ReportDevices.fromMap(jsonDecode(response.body));
      }
      else{
        throw response.statusCode;
      }
    }on HttpException catch(error){
      throw error;
    }
  }
}