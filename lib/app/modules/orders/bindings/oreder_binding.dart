import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/orders/controllers/order_controller.dart';

class OrderBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<OrderController>(() => OrderController());
  }

}