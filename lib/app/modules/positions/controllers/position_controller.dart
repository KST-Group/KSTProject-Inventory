import 'package:get/get.dart';
import 'package:kst_inventory/services/position_service.dart';

class PositionController extends GetxController {
  @override
  void onInit() {
    getPosition();
    super.onInit();
  }

  ///Get data
  var listPosition = [].obs;

  void getPosition() {
    PositionServices.to.getPosition().then((value) {
      listPosition.value = value.data!;
    });
  }

  ///Add data
  var position = ''.obs;
  var description = ''.obs;

  void addData() {
    PositionServices.to.addPositionData(data: {
      'position': position.value,
      'description': description.value,
    }).then((value) {
      getPosition();
      print(value);
    });
  }

  ///Delete Position
  void deletePosition({required String positionId}) {
    PositionServices.to.deletePosition(positionId: positionId).then((value) {
      getPosition();
      print(value);
    });
  }
}
