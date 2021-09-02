import 'package:kst_inventory/app/modules/employees/bindings/employee_binding.dart';
import 'package:kst_inventory/models/brand.dart';
import 'package:kst_inventory/models/companys.dart';
import 'package:kst_inventory/services/checkout_services.dart';

const String _baseUrl = "kst-inventory.herokuapp.com";

final Uri loginUrl = Uri.https(_baseUrl, '/login');

///User
Uri getAUserUrl(String username) => Uri.https(_baseUrl, '/users/$username');
Uri getUserUrl = Uri.https(_baseUrl, '/users');
Uri addUserUrl = Uri.https(_baseUrl, '/users/add');

Uri deleteUserUrl(String username) => Uri.https(_baseUrl, '/users/$username');

///Device
Uri deviceUrl = Uri.https(_baseUrl, '/devices');
Uri addDeviceUrl = Uri.https(_baseUrl, '/devices/add');

Uri getDeviceByIdeUrl(String deviceId) =>
    Uri.https(_baseUrl, '/devices/$deviceId');
Uri deleteByIdeUrl = Uri.https(_baseUrl, '/devices/del');

///DevicesType
Uri typeUrl = Uri.https(_baseUrl, '/devicetype');
Uri addTypeUrl = Uri.https(_baseUrl, '/devicetype/add');

///Brands
Uri brandUrl = Uri.https(_baseUrl, '/brands');
Uri addBrandUrl = Uri.https(_baseUrl, '/brands/add');

///Company
Uri companyUrl = Uri.https(_baseUrl, '/company');
Uri deleteCompanyUrl = Uri.https(_baseUrl, '/company/delete');
Uri addCompanyUrl = Uri.https(_baseUrl, '/company/add');

///Department
Uri departByCompany(String companyId) =>
    Uri.https(_baseUrl, '/department/cm/$companyId');
Uri addDepartmentUrl = Uri.https(_baseUrl, '/department/add');
Uri getDepartmentUrl = Uri.https(_baseUrl, '/department');
Uri deleteDepartmentUrl = Uri.https(_baseUrl, '/department/delete');

///Positions
Uri positionUrl = Uri.https(_baseUrl, '/position');
Uri addPositionUrl = Uri.https(_baseUrl, '/position/add');
Uri deletePositionUrl = Uri.https(_baseUrl, '/position/delete');

///Employee
Uri employeeUrl = Uri.https(_baseUrl, '/employee');
Uri addEmployeeUrl = Uri.https(_baseUrl, '/employee/add');
Uri delEmployeeUrl = Uri.https(_baseUrl, '/employee/del');

///Checkout
Uri checkoutDeviceUrl = Uri.https(_baseUrl, '/checkout/add');
Uri checkoutDetailUrl = Uri.https(_baseUrl, '/checkout/detail');
Uri updateStatusUrl = Uri.https(_baseUrl, '/checkout/status');
Uri checkOutDataUrl = Uri.https(_baseUrl, '/checkout');
