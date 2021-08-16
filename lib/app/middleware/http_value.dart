import 'package:kst_inventory/models/brand.dart';

const String _baseUrl = "127.0.0.1:3000";

final Uri loginUrl = Uri.http(_baseUrl, '/login');

///User
Uri getAUserUrl(String username) => Uri.http(_baseUrl, '/users/$username');
Uri getUserUrl = Uri.http(_baseUrl, '/users');
Uri addUserUrl = Uri.http(_baseUrl, '/users/add');
Uri deleteUserUrl(String username) => Uri.http(_baseUrl, '/users/$username');

///Device
Uri deviceUrl = Uri.http(_baseUrl, '/devices');
///DevicesType
Uri typeUrl = Uri.http(_baseUrl, '/devicetype');
Uri addTypeUrl = Uri.http(_baseUrl, '/devicetype/add');


///Brands
Uri brandUrl = Uri.http(_baseUrl, '/brands');
Uri addBrandUrl = Uri.http(_baseUrl, '/brands/add');