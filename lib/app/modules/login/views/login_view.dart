import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kst_inventory/app/modules/login/controllers/login_controller.dart';
import 'package:kst_inventory/models/user_model.dart';
import 'package:kst_inventory/services/prefs_service.dart';

import 'components/TextInput.dart';
import 'components/loader.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      builder: (context, delegate, currentRoute) {
        return Scaffold(
          backgroundColor: Colors.blueGrey,
          body: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Obx(() {
                    if (controller.isLoggedIn.value == true) {
                      return _errorSession();
                    }
                    return Container();
                  }),
                  Form(
                    key: controller.loginFormKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 60, right: 60, top: 50, bottom: 30),
                        color: Colors.white,
                        width: 500,
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _logoApp(context),
                                SizedBox(
                                  height: 18,
                                ),
                                Text(
                                  'Log In',
                                  style: GoogleFonts.notoSans(
                                    textStyle:
                                    Theme.of(context).textTheme.headline6,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextInput(
                                  hint: 'Username',
                                  secure: false,
                                  controller: controller.usernameController,
                                  onSaved: (value) {
                                    controller.username = value!;
                                  },
                                  validator: (value) =>
                                      controller.validateUsername(value!),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextInput(
                                  controller: controller.passwordController,
                                  hint: 'Password',
                                  secure: true,
                                  onSaved: (value) =>
                                  controller.password = value!,
                                  validator: (value) =>
                                      controller.validatePassword(value!),
                                ),
                                _checkBoxRemember(),
                                _loginButton(delegate),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    "If you're forgot your Username or Password contact to Support team")
                              ],
                            ),
                            Obx(() {
                              if (controller.loading.value) {
                                return Loader();
                              }
                              return Container();
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _logoApp(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Image(
            image: AssetImage('assets/images/kst.png'),
            width: 40,
            height: 40,
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            "KST Inventory",
            style: GoogleFonts.notoSans(
              textStyle: Theme.of(context).textTheme.headline6,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  _checkBoxRemember() {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.all(0),
        leading: Obx(
              () => Checkbox(
            value: controller.isCheck.value,
            onChanged: (bool? value) => controller.isCheck.value = value!,
          ),
        ),
        title: Text('Remember me'),
      ),
    );
  }

  _loginButton(GetDelegate delegate) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        child: InkWell(
          child: Container(
            width: 80,
            height: 30,
            color: Colors.blue,
            child: Center(
              child: Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          onTap: () {
            controller.isLoggedIn.value = false;
            controller.checkLogin();
          },
        ),
      ),
    );
  }

  _errorSession() {
    return Container(
      margin: EdgeInsets.only(left: 5, bottom: 20),
      width: 500,
      child: Row(
        children: [
          Container(height: 80, width: 2, color: Colors.red),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Something went wrong',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/sad_face.svg',
                        width: 40,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.message.value,
                            style: TextStyle(color: Colors.red),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Please try again',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}