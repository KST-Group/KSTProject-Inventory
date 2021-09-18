import 'package:get/get.dart';
import 'package:kst_inventory/app/middleware/auth_middleware.dart';
import 'package:kst_inventory/app/modules/check_in/bindings/checkin_binding.dart';
import 'package:kst_inventory/app/modules/check_in/views/checkin_detail_view.dart';
import 'package:kst_inventory/app/modules/check_in/views/checkin_view.dart';
import 'package:kst_inventory/app/modules/check_out/bindings/check_out_binding.dart';
import 'package:kst_inventory/app/modules/check_out/views/check_out_view.dart';
import 'package:kst_inventory/app/modules/companys/bindings/company_binding.dart';
import 'package:kst_inventory/app/modules/companys/views/company_detail_view.dart';
import 'package:kst_inventory/app/modules/companys/views/company_view.dart';
import 'package:kst_inventory/app/modules/dashboard/bindings/dashboard_binding.dart';
import 'package:kst_inventory/app/modules/dashboard/views/dashboard_view.dart';
import 'package:kst_inventory/app/modules/dashboard/views/device_view_dashboard.dart';
import 'package:kst_inventory/app/modules/departments/bindings/department_blinding.dart';
import 'package:kst_inventory/app/modules/departments/views/department_detail.dart';
import 'package:kst_inventory/app/modules/departments/views/department_view.dart';
import 'package:kst_inventory/app/modules/devices/bindings/device_binding.dart';
import 'package:kst_inventory/app/modules/devices/views/device_view.dart';
import 'package:kst_inventory/app/modules/devices/views/device_detail_view.dart';
import 'package:kst_inventory/app/modules/employees/bindings/employee_binding.dart';
import 'package:kst_inventory/app/modules/employees/views/employee_view.dart';
import 'package:kst_inventory/app/modules/home/bindings/home_binding.dart';
import 'package:kst_inventory/app/modules/home/views/home_view.dart';
import 'package:kst_inventory/app/modules/login/bindings/login_binding.dart';
import 'package:kst_inventory/app/modules/login/views/login_view.dart';
import 'package:kst_inventory/app/modules/orders/bindings/oreder_binding.dart';
import 'package:kst_inventory/app/modules/orders/views/order_detail_view.dart';
import 'package:kst_inventory/app/modules/orders/views/order_view.dart';
import 'package:kst_inventory/app/modules/positions/bindings/position_binding.dart';
import 'package:kst_inventory/app/modules/positions/views/position_detial_view.dart';
import 'package:kst_inventory/app/modules/positions/views/position_view.dart';
import 'package:kst_inventory/app/modules/repaires/bindings/repair_binding.dart';
import 'package:kst_inventory/app/modules/repaires/views/repair_detail_view.dart';
import 'package:kst_inventory/app/modules/repaires/views/repair_view.dart';
import 'package:kst_inventory/app/modules/reports/bindings/report_binding.dart';
import 'package:kst_inventory/app/modules/reports/views/device_report.dart';
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
      middlewares: [
        EnsureAuthedMiddleware(),
      ],
      children: [
        GetPage(
          name: Paths.LOGIN,
          page: () => LoginView(),
          binding: LoginBinding(),
          middlewares: [
            EnsureNotAuthedMiddleware(),
          ],
        ),
        GetPage(
          preventDuplicates: true,
          name: Paths.HOME,
          page: () => HomeView(),
          bindings: [
            HomeBinding(),
          ],
          middlewares: [
            //EnsureAuthedMiddleware(),
          ],
          title: null,
          children: [
            GetPage(
              name: Paths.DASHBOARD,
              page: () => DashboardView(),
              binding: DashboardBinding(),
              middlewares: [
                //EnsureAuthedMiddleware(),
              ],
              children: [
                GetPage(
                  name: Paths.DEVICE_VIEW_DASHBOARD,
                  page: () => DeviceViewDashboard(),
                  binding: DashboardBinding(),
                )
              ],
            ),
            GetPage(
              middlewares: [
                //EnsureAuthedMiddleware(),
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
                children: [
                  GetPage(
                    name: Paths.DEVICE_DETAIL,
                    page: () => DeviceViewDetail(),
                    binding: DeviceBinding(),
                  ),
                ]),
            GetPage(
                name: Paths.CHECKIN,
                page: () => CheckInView(),
                binding: CheckInBinding(),
                children: [
                  GetPage(
                    name: Paths.CHECK_DETAIL,
                    page: () => CheckInDetailView(),
                    binding: CheckInBinding(),
                  ),
                ]),
            GetPage(
              name: Paths.CHECKOUT,
              page: () => CheckOutView(),
              binding: CheckOutBinding(),
            ),

            ///Order Device
            GetPage(
                name: Paths.ORDER,
                page: () => OrderView(),
                binding: OrderBinding(),
                children: [
                  GetPage(
                    name: Paths.ORDER_DETAIL,
                    page: () => OrderDetailView(),
                    binding: OrderBinding(),
                  )
                ]),
            GetPage(
              name: Paths.EMPLOYEE,
              page: () => EmployeeView(),
              binding: EmployeeBinding(),
              // middlewares: [
              //   EnsureAuthedMiddleware(),
              // ],
            ),

            GetPage(
                name: Paths.REPAIR,
                page: () => RepairView(),
                binding: RepairBinding(),
                children: [
                  GetPage(
                    name: Paths.ADDREPAIR,
                    page: () => RepairDetail(),
                    binding: RepairBinding(),
                  )
                ]),
            GetPage(
                name: Paths.COMPANY,
                page: () => CompanyView(),
                binding: CompanyBinding(),
                transition: Transition.zoom,
                children: [
                  GetPage(
                    name: Paths.COMPANY_DETAIL,
                    page: () => CompanyDetailView(),
                    binding: CompanyBinding(),
                  ),
                ]
                // middlewares: [
                //   EnsureAuthedMiddleware(),
                // ],
                ),
            GetPage(
              name: Paths.DEPARTMENT,
              page: () => DepartmentView(),
              binding: DepartmentBinding(),
              // middlewares: [
              //   EnsureAuthedMiddleware(),
              // ]
              children: [
                GetPage(
                  name: Paths.DEPART_DETAIL,
                  page: () => DepartmentDetailView(),
                  binding: DepartmentBinding(),
                )
              ],
            ),
            GetPage(
                name: Paths.POSITION,
                page: () => PositionView(),
                binding: PositionBinding(),
                // middlewares: [
                //   EnsureAuthedMiddleware(),
                // ]
                children: [
                  GetPage(
                    name: Paths.POSITION_DETIAL,
                    page: () => PositionDetailView(),
                    binding: PositionBinding(),
                  ),
                ]),
            GetPage(
              name: Paths.USER,
              page: () => UserView(),
              binding: UserBinding(),
            ),
            GetPage(
              name: Paths.REPORT_DEVICE,
              page: () => ReportDevice(),
              binding: ReportBinding(),
            )
          ],
        ),
      ],
    ),
  ];
}
