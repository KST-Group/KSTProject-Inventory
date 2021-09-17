import 'package:get/get.dart';
import 'package:kst_inventory/app/routes/app_routes.dart';
import 'package:kst_inventory/services/auth_service.dart';

class EnsureAuthedMiddleware extends GetMiddleware {
  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    if (!AuthService.to.isLoggedInValue) {
      final newRoute = Routes.LOGIN_THEN(route.location!);
      return GetNavConfig.fromRoute(newRoute);
    }
    return await super.redirectDelegate(route);
  }
}




class EnsureNotAuthedMiddleware extends GetMiddleware {
  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    if (AuthService.to.isLoggedInValue) {
      //NEVER navigate to auth screen, when user is already authed
      return null;

      //OR redirect user to another screen
      //return GetNavConfig.fromRoute(Routes.PROFILE);
    }
    return await super.redirectDelegate(route);
  }
}
