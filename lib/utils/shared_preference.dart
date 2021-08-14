import 'package:kst_inventory/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  Future<bool> saveUser(String username) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);
    if (prefs.get('username') == null || prefs.get('username') == '') {
      return false;
    } else {
      return true;
    }
  }

  Future<String> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    return username!;
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('username');
  }
}
