import 'package:get/get.dart';

class UserProvider extends GetConnect{
  Future<Response>deleteUser(Map data)=>delete('http://127.0.0.1:5000/users/delete');
}