import 'package:get/get.dart';
import 'package:kst_inventory/models/user_model.dart';
import 'package:kst_inventory/services/prefs_service.dart';
import 'package:kst_inventory/services/user_service.dart';

class HomeController extends GetxController {
  var userPrefs = ''.obs;
  var displayName=''.obs;
  List<User>userList=[];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  ///Get user from SharedPreference
  void getUserPref() {
    PrefsService.to.getUser().then((value) {
      return userPrefs.value = value;
    });
  }

  ///Get user data from database
  getUserData() async {

  }

  @override
  void onClose() {
    super.onClose();
  }
}
