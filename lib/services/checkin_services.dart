import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kst_inventory/app/middleware/http_value.dart';
import 'package:kst_inventory/models/check_in_detail.dart';
import 'package:kst_inventory/models/checkin.dart';

class CheckInServices extends GetxService {
  static CheckInServices get to=>Get.find();
  Future<CheckInDevice> getDataCheckIn() async {
    try {
      final response = await http.get(checkInDataUrl);
      if (response.statusCode == 200) {
        return CheckInDevice.fromMap(jsonDecode(response.body));
      } else {
        throw response.statusCode;
      }
    } on HttpException catch (error) {
      throw error;
    }
  }

  ///Create Check in
  Future<CheckIn>createCheckIn({required Map<String,dynamic>data})async{
    try{
      final response=await http.post(addCheckInDataUrl,body: data);
      if (response.statusCode==200) {
        return CheckIn.fromMap(jsonDecode(response.body));
      }  else{
        throw response.statusCode;
      }
    }on HttpException catch(error){
      throw error;
    }
  }

  ///Add CheckIn Detail
  Future<Details>addCheckIn({required Map<String,dynamic>data})async{
    try{
      final response=await http.post(addCheckInDetailDataUrl,body: data);
      if (response.statusCode==200) {
        return Details.fromMap(jsonDecode(response.body));
      }  else{
        throw response.statusCode;
      }
    }on HttpException catch(error){
      throw error;
    }
  }


}
