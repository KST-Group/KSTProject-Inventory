abstract class Routes {
  Routes._();

  static const ROOT = Paths.ROOT;
  static const HOME = Paths.HOME;
  static const LOGIN = Paths.LOGIN;
  static const DASHBOARD = Paths.HOME + Paths.DASHBOARD;

  static String DEVICE_VIEW_DASHBOARD(String deviceId) =>
      '$DASHBOARD/$deviceId';
  static const SETTING = Paths.HOME + Paths.SETTING;
  static const DEVICE = Paths.HOME + Paths.DEVICE;

  static String DEVICE_DETAIL(String deviceId) => '$DEVICE/$deviceId';

  static const CHECKIN = Paths.HOME + Paths.CHECKIN;

  static String CHECKIN_DETAIL(String employeeId) => '$CHECKIN/$employeeId';
  static const CHECKOUT = Paths.HOME + Paths.CHECKOUT;
  static const USER = Paths.HOME + Paths.USER;
  static const EMPLOYEE = Paths.HOME + Paths.EMPLOYEE;
  static const COMPANY = Paths.HOME + Paths.COMPANY;

  static String DEPARTMENT_DETAIL(String departmentId) =>
      '$DEPARTMENT/$departmentId';
  static const POSITION = Paths.HOME + Paths.POSITION;

  static String POSITION_DETAIL(String positionId) => '$POSITION/$positionId';

  static String COMPANY_DTAIL(String companyId) => '$COMPANY/$companyId';
  static const DEPARTMENT = Paths.HOME + Paths.DEPARTMENT;

  static String LOGIN_THEN(String afterSuccessfulLogin) =>
      '$LOGIN?then=${Uri.encodeQueryComponent(afterSuccessfulLogin)}';

  static const ORDER = Paths.HOME + Paths.ORDER;

  static String ORDER_DETAIL(String orderId) => '$ORDER/$orderId';

  static const REPAIR = Paths.HOME + Paths.REPAIR;
  static const ADDREPAIR = Paths.HOME + Paths.REPAIR + Paths.ADDREPAIR;

  static const REPORT_DEVICE = Paths.HOME + Paths.REPORT_DEVICE;
}

abstract class Paths {
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const DASHBOARD = '/dashboard';
  static const DEVICE_VIEW_DASHBOARD = '/:employeeId';
  static const SETTING = '/setting';
  static const DEVICE = '/device';
  static const DEVICE_DETAIL = '/:deviceId';
  static const CHECKIN = '/checkin';
  static const CHECK_DETAIL = '/:employeeId';
  static const CHECKOUT = '/checkout';
  static const USER = '/user';
  static const EMPLOYEE = '/employee';
  static const COMPANY = '/company';
  static const COMPANY_DETAIL = '/:companyId';
  static const DEPARTMENT = '/department';
  static const DEPART_DETAIL = '/:departmentId';
  static const POSITION = '/position';
  static const POSITION_DETIAL = '/:positionId';
  static const ORDER = '/order';
  static const ORDER_DETAIL = '/:orderId';

  static const REPAIR = '/repair';
  static const ADDREPAIR = '/addrepair';

  static const ROOT = '/root';

  static const REPORT_DEVICE = '/report-device';
}
