import 'package:kst_inventory/app/modules/orders/controllers/order_controller.dart';
import 'package:kst_inventory/models/repairs.dart';

const String _baseUrl = "127.0.0.1:3000";

final Uri loginUrl = Uri.http(_baseUrl, '/login');

///User
Uri getAUserUrl(String username) => Uri.http(_baseUrl, '/users/$username');
Uri getUserUrl = Uri.http(_baseUrl, '/users');
Uri addUserUrl = Uri.http(_baseUrl, '/users/add');
Uri updateUserUrl = Uri.http(_baseUrl, '/users/up');

Uri deleteUserUrl(String username) => Uri.http(_baseUrl, '/users/$username');

///Device
Uri deviceUrl = Uri.http(_baseUrl, '/devices');

Uri addDeviceUrl = Uri.http(_baseUrl, '/devices/add');

Uri getDeviceByIdeUrl(String deviceId) =>
    Uri.http(_baseUrl, '/devices/id/$deviceId');
Uri deleteByIdeUrl = Uri.http(_baseUrl, '/devices/del');
Uri usingDevice = Uri.http(_baseUrl, '/devices/use');
Uri updateStatusDeviceUrl = Uri.http(_baseUrl, '/devices/upstatus');

///DevicesType
Uri typeUrl = Uri.http(_baseUrl, '/devicetype');
Uri addTypeUrl = Uri.http(_baseUrl, '/devicetype/add');

///Brands
Uri brandUrl = Uri.http(_baseUrl, '/brands');
Uri addBrandUrl = Uri.http(_baseUrl, '/brands/add');

///Company
Uri companyUrl = Uri.http(_baseUrl, '/company');
Uri deleteCompanyUrl = Uri.http(_baseUrl, '/company/delete');
Uri addCompanyUrl = Uri.http(_baseUrl, '/company/add');

///Department
Uri departByCompany(String companyId) =>
    Uri.http(_baseUrl, '/department/cm/$companyId');
Uri addDepartmentUrl = Uri.http(_baseUrl, '/department/add');
Uri getDepartmentUrl = Uri.http(_baseUrl, '/department');
Uri deleteDepartmentUrl = Uri.http(_baseUrl, '/department/delete');

///Positions
Uri positionUrl = Uri.http(_baseUrl, '/position');
Uri addPositionUrl = Uri.http(_baseUrl, '/position/add');
Uri deletePositionUrl = Uri.http(_baseUrl, '/position/delete');

///Employee
Uri employeeUrl = Uri.http(_baseUrl, '/employee');
Uri addEmployeeUrl = Uri.http(_baseUrl, '/employee/add');
Uri delEmployeeUrl = Uri.http(_baseUrl, '/employee/del');
Uri delEmployeeDeviceUrl = Uri.http(_baseUrl, '/employee/device');
Uri employeeUsingDeviceUrl = Uri.http(_baseUrl, '/employee/usings');
Uri updateUrl = Uri.http(_baseUrl, '/employee/up');
Uri empDeviceUrl(String deviceId) => Uri.http(_baseUrl, '/employee/device/$deviceId');

///Checkout
Uri checkoutDeviceUrl = Uri.http(_baseUrl, '/checkout/add');
Uri checkoutDetailUrl = Uri.http(_baseUrl, '/checkout/detail');
Uri updateStatusUrl = Uri.http(_baseUrl, '/checkout/status');
Uri checkOutDataUrl = Uri.http(_baseUrl, '/checkout');
Uri addOutLogUrl = Uri.http(_baseUrl, '/checkout/log');


///CheckIn
Uri checkInDataUrl = Uri.http(_baseUrl, '/checkin');
Uri addCheckInDataUrl = Uri.http(_baseUrl, '/checkin/add');
Uri addCheckInDetailDataUrl = Uri.http(_baseUrl, '/checkin/adddetail');
Uri checkInViewUrl = Uri.http(_baseUrl, '/checkin/view');
Uri delCheckOutDe = Uri.http(_baseUrl, '/checkout/delDetail');
Uri addLogUrl = Uri.http(_baseUrl, '/checkin/log');




///Order
Uri orderDataUrl = Uri.http(_baseUrl, '/order');

///Repair
Uri addRepairUrl = Uri.http(_baseUrl, '/repairs/add');
Uri getRepairUrl = Uri.http(_baseUrl, '/repairs');
Uri adRepairLogUrl = Uri.http(_baseUrl, '/repairs/log');
Uri delRepairLogUrl = Uri.http(_baseUrl, '/repairs/del');
Uri getDevRepairLogUrl = Uri.http(_baseUrl, '/repairs/dev');
Uri addReceiveLogUrl = Uri.http(_baseUrl, '/repairs/addrev');


///Repaort
Uri addReportUrl = Uri.http(_baseUrl, '/reports/device');
///
///
