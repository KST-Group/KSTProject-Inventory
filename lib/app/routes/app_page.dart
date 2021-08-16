import 'package:get/get.dart';
import 'package:kst_inventory/app/middleware/auth_middleware.dart';
import 'package:kst_inventory/app/modules/check_in/bindings/checkin_binding.dart';
import 'package:kst_inventory/app/modules/check_in/views/checkin_view.dart';
import 'package:kst_inventory/app/modules/dashboard/bindings/dashboard_binding.dart';
import 'package:kst_inventory/app/modules/dashboard/views/dashboard_view.dart';
import 'package:kst_inventory/app/modules/devices/bindings/device_binding.dart';
import 'package:kst_inventory/app/modules/devices/views/device_view.dart';
import 'package:kst_inventory/app/modules/employees/bindings/employee_binding.dart';
import 'package:kst_inventory/app/modules/employees/views/employee_view.dart';
import 'package:kst_inventory/app/modules/home/bindings/home_binding.dart';
import 'package:kst_inventory/app/modules/home/views/home_view.dart';
import 'package:kst_inventory/app/modules/login/bindings/login_binding.dart';
import 'package:kst_inventory/app/modules/login/views/login_view.dart';
import 'package:kst_inventory/app/modules/root/bindings/root_binding.dart';
import 'package:kst_inventory/app/modules/root/views/root_view.dart';
import 'package:kst_inventory/app/modules/settings/bindings/settong_binding.dart';
import 'package:kst_inventory/app/modules/settings/views/setting_view.dart';
import 'package:kst_inventory/app/modules/users/bindings/user_binding.dart';
import 'package:kst_inventory/app/modules/users/views/user_view.dart';

import 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;
  static final routes = [
    GetPage(
      name: '/',
      page: () => RootView(),
      binding: RootBinding(),
      participatesInRootNavigator: true,
      preventDuplicates: true,
      children: [
        GetPage(
          middlewares: [
            EnsureNotAuthedMiddleware(),
          ],
          name: Paths.LOGIN,
          page: () => LoginView(),
          binding: LoginBinding(),
        ),
        GetPage(
          preventDuplicates: true,
          name: Paths.HOME,
          page: () => HomeView(),
          bindings: [
            HomeBinding(),
          ],
          middlewares: [
            OnReadLoggedIn(),
          ],
          title: null,
          children: [
            GetPage(
              name: Paths.DASHBOARD,
              page: () => DashboardView(),
              binding: DashboardBinding(),
            ),
            GetPage(
              middlewares: [
                EnsureAuthedMiddleware(),
              ],
              name: Paths.SETTING,
              page: () => SettingView(),
              binding: SettingBinding(),
              transition: Transition.size,
            ),
            GetPage(
              name: Paths.DEVICE,
              page: () => DeviceView(),
              binding: DeviceBinding(),
            ),
            GetPage(
              name: Paths.CHECKIN,
              page: () => CheckInView(),
              binding: CheckInBinding(),
            ),
            GetPage(
              name: Paths.EMPLOYEE,
              page: () => EmployeeView(),
              binding: EmployeeBinding(),
              // middlewares: [
              //   EnsureAuthedMiddleware(),
              // ],
            ),
            GetPage(
              name: Paths.USER,
              page: () => UserView(),
              binding: UserBinding(),
            ),
          ],
        ),
      ],
    ),
  ];
}
