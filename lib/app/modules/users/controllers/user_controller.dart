import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kst_inventory/services/user_service.dart';
import 'package:kst_inventory/utils/dialog.dart';

class UserController extends GetxController {
  var userList = [].obs;
  TextEditingController? username;
  TextEditingController? password;
  TextEditingController? displayName;

  ///Validation
  final GlobalKey<FormState> userFormKey = GlobalKey<FormState>();

  String? validateUsername(String value) {
    if (!GetUtils.isUsername(value)) {
      return "Provide valid username";
    }
    return null;
  }

  String? validateDisplayName(String value) {
    if (value.isEmpty) {
      return "Provide valid username";
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.length < 6) {
      return "Password must be of 6 character";
    }
    return null;
  }

  @override
  void onInit() {
    fetchAllUser();
    username = TextEditingController();
    password = TextEditingController();
    displayName = TextEditingController();
    super.onInit();
  }

  Future<void> fetchAllUser() async {
    userList.clear();
    UserServices.to.getUserData().then((value) {
      value.data!.forEach((docs) {
        userList.add(docs);
      });
    });
  }

  Future<void> insertData(BuildContext context) async {
    Dialogs(context: context, message: 'Do you want to add user?').optionDialog(
      onPress: () {
        UserServices.to
            .addUser(
          username: username!.text,
          password: password!.text,
          displayName: displayName!.text,
        )
            .then(
          (value) {
            fetchAllUser();
            username!.clear();
            password!.clear();
            displayName!.clear();
            print(value['error']);
          },
        );
      },
    );
  }

  Future<void> deleteUser(
      {required String username, required BuildContext context}) async {
    UserServices.to.deleteUser(username: username).then((value) {
      fetchAllUser();
      Dialogs(context: context, message: 'Success').showToast();
      print('message=$value');
    });
  }

  @override
  void dispose() {
    username!.dispose();
    password!.dispose();
    displayName!.dispose();

    super.dispose();
  }
}
