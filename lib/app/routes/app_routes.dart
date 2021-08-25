abstract class Routes {
  Routes._();

  static const HOME = Paths.HOME;
  static const LOGIN = Paths.LOGIN;
  static const DASHBOARD = Paths.HOME + Paths.DASHBOARD;
  static const SETTING = Paths.HOME + Paths.SETTING;
  static const DEVICE = Paths.HOME + Paths.DEVICE;

  static String DEVICE_DETAIL(String deviceId) => '$DEVICE/$deviceId';

  static const CHECKIN = Paths.HOME + Paths.CHECKIN;
  static const CHECKOUT=Paths.HOME+Paths.CHECKOUT;
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
}

abstract class Paths {
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const DASHBOARD = '/dashboard';
  static const SETTING = '/setting';
  static const DEVICE = '/device';
  static const DEVICE_DETAIL = '/:deviceId';
  static const CHECKIN = '/checkin';
  static const CHECKOUT='/checkout';
  static const USER = '/user';
  static const EMPLOYEE = '/employee';
  static const COMPANY = '/company';
  static const COMPANY_DETAIL = '/:companyId';
  static const DEPARTMENT = '/department';
  static const DEPART_DETAIL = '/:departmentId';
  static const POSITION = '/position';
  static const POSITION_DETIAL = '/:positionId';
}
