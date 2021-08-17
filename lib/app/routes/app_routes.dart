abstract class Routes {
  Routes._();

  static const HOME = Paths.HOME;
  static const LOGIN = Paths.LOGIN;
  static const DASHBOARD = Paths.HOME + Paths.DASHBOARD;
  static const SETTING = Paths.HOME + Paths.SETTING;
  static const DEVICE = Paths.HOME + Paths.DEVICE;
  static const CHECKIN = Paths.HOME + Paths.CHECKIN;
  static const USER = Paths.HOME + Paths.USER;
  static const EMPLOYEE = Paths.HOME + Paths.EMPLOYEE;
  static const COMPANY=Paths.HOME+Paths.COMPANY;
  static String COMPANY_PROFILE(String companyId)=>'$COMPANY/$companyId';


  static String LOGIN_THEN(String afterSuccessfulLogin) =>
      '$LOGIN?then=${Uri.encodeQueryComponent(afterSuccessfulLogin)}';
}

abstract class Paths {
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const DASHBOARD = '/dashboard';
  static const SETTING = '/setting';
  static const DEVICE = '/device';
  static const CHECKIN = '/checkin';
  static const USER = '/user';
  static const EMPLOYEE = '/employee';
  static const COMPANY='/company';
  static const COMPANY_PROFILE='/:companyId';
}
