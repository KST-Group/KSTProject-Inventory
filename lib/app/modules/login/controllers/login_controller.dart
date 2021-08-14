import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:kst_inventory/app/routes/app_routes.dart';
import 'package:kst_inventory/services/auth_service.dart';
import 'package:kst_inventory/services/prefs_service.dart';

class LoginController extends GetxController {
  ///Validate form
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  late TextEditingController usernameController, passwordController;
  var username = '';
  var password = '';

  ///CheckBox
  var isCheck = false.obs;

  ///Loading...
  var loading = false.obs;

  ///Login
  var isLoggedIn = false.obs;
  RxString message = RxString('');

  @override
  void onInit() {
    super.onInit();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  String? validateUsername(String value) {
    if (!GetUtils.isUsername(value)) {
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

  void checkLogin(GetDelegate delegate) async {
    final isValid = loginFormKey.currentState!.validate();
    if (isValid) {
      loading.value = true;
      loginFormKey.currentState!.save();
      AuthService.to.login(username: username, password: password).then(
        (value) async {
          if (AuthService.to.isLoggedInValue) {
            if (isCheck.value) {
              PrefsService.to
                  .saveUser(username)
                  .then((value) => print('Saved'));
            }
            await Future.delayed(Duration(seconds: 2));
            print('Message Controller=${value.message}');
            loading.value = false;
            final thenTo = Get.rootDelegate.currentConfiguration!.currentPage!
                .parameters?['then'];
            Get.rootDelegate.offNamed(thenTo ?? Routes.HOME);
          } else {
            await Future.delayed(Duration(seconds: 2));
            isLoggedIn.value = true;
            loading.value = false;

            message.value = value.message!;
            print('Message Controller=${value.message}');
          }
        },
      );
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();

    super.onClose();
  }
}
