import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsService extends GetxService {
  static PrefsService get to => Get.find();
  final username = ''.obs;

  String get userValue => username.value;

  Future<void> saveUser(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);
  }

  Future<String> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('username');
    username.value = user.toString();
    return username.value;
  }

  Future<void> removeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
