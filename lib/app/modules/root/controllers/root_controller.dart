import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RootController extends GetxController {
  final String PREP_KEY = 'username';
  RxString username = RxString('');
  @override
  void onInit() {
    checkUserLogin();
    super.onInit();
  }

  Future checkUserLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    username.value = preferences.getString(PREP_KEY)!;
  }

  Future setUserPrep({required String username}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(PREP_KEY, username);
  }

  Future delUserPrep() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }
}
