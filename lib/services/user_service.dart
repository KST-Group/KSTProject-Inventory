import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:kst_inventory/app/middleware/http_value.dart';
import 'package:kst_inventory/models/user_model.dart';

class UserServices extends GetxService {
  static UserServices get to => Get.find();

  Future<UserModel> getUserData() async {
    final response = await http.get(getUserUrl);
    final jsonStr = jsonDecode(response.body);
    return UserModel.fromMap(jsonStr);
  }

  Future addUser({
    required String username,
    required String password,
    required String displayName,
  }) async {
    final response = await http.post(addUserUrl, body: {
      'username': username,
      'passwords': password,
      'surname': displayName,
    });
    if (response.statusCode == 200) {
      final jsonStr = jsonDecode(response.body);
      return jsonStr;
    }
    return response.statusCode;
  }

  Future deleteUser({required String username}) async {
    final response = await http.delete(deleteUserUrl(username));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return response.statusCode;
  }

  Future<UserModel> getUserById(String username) async {
    final response = await http.get(getAUserUrl(username));
    if (response.statusCode == 200) {
      final jsonToStr = jsonDecode(response.body);
      return UserModel.fromMap(jsonToStr);
    }
    throw "Error";
  }

  ///update user
  Future updateUser({required Map<String, dynamic> data}) async {
    try {
      final response = await http.put(updateUserUrl, body: data);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw response.statusCode;
      }
    } on HttpException catch (error) {
      throw error;
    }
  }
}
