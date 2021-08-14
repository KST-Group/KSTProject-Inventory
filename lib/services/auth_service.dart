import 'dart:convert';

import 'package:get/get.dart';
import 'package:kst_inventory/models/user_model.dart';
import 'package:kst_inventory/services/prefs_service.dart';
import 'package:http/http.dart' as http;
import 'package:kst_inventory/app/middleware/http_value.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();

  final isLoggedIn = false.obs;

  bool get isLoggedInValue => isLoggedIn.value;

  Future<UserModel> login({String? username, String? password}) async {
    final response = await http.post(loginUrl, body: {
      'username': username,
      'passwords': password,
    });
    if (response.statusCode == 200) {
      final jsonToStr = jsonDecode(response.body);
      final data = UserModel.fromMap(jsonToStr);
      if (data.error!) {
        return data;
      } else {
        isLoggedIn.value = true;
        return data;
      }
    }
    throw 'error';
  }

  void logout() {
    isLoggedIn.value = false;
  }
}
