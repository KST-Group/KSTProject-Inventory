import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/models/user_model.dart';

import 'package:kst_inventory/services/user_service.dart';
import 'package:kst_inventory/utils/dialog.dart';

class UserController extends GetxController {
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

  final List<String> userColumn = [
    'No',
    '',
    'Username',
    '',
    'Display Name',
    '',
    'Crate Date',
    '',
    'Last Update',
    '',
    'Action'
  ];

  @override
  void onInit() {
    getAllUser();
    username = TextEditingController();
    password = TextEditingController();
    displayName = TextEditingController();
    super.onInit();
  }

  ///Get All User data
  RxList<User> listUser = RxList([]);

  Future<void> getAllUser() async {
    UserServices.to.getUserData().then((value) {
      listUser.value = value.data!;
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
            getAllUser();
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
      {required String username}) async {
    UserServices.to.deleteUser(username: username).then((value) {
      getAllUser();
      Get.rootDelegate.popRoute();
      Fluttertoast.showToast(msg: 'Success', webPosition: 'center');


    });
  }

  ///Update user
  String? usernameController;
  TextEditingController displayNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void updateUserData() {
    UserServices.to
        .updateUser(
            data: User(
      username: usernameController,
      surname: displayNameController.text,
      passwords: passwordController.text,
    ).toMap())
        .then((value) {
      print(value['message']);
      getAllUser();
      usernameController = '';
      displayNameController.clear();
      Get.rootDelegate.popRoute();
      passwordController.clear();
      Fluttertoast.showToast(msg: 'Success', webPosition: 'center');
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
