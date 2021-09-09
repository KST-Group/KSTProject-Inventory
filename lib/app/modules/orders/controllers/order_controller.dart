import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/models/brand.dart';
import 'package:kst_inventory/models/device.dart';
import 'package:kst_inventory/models/device_model.dart';
import 'package:kst_inventory/models/device_type.dart';
import 'package:kst_inventory/models/orders.dart';
import 'package:kst_inventory/services/device_services.dart';
import 'package:kst_inventory/services/order_services.dart';

class OrderController extends GetxController {
  ///Global
  var total = '10,000,000'.obs;
  List<String> orderColumn = [
    'No',
    'Model',
    'Price',
    'QTY',
  ];

  @override
  void onInit() {
    getOrderData();
    getDeviceData();
    getDeviceType();
    getBrandData();

    super.onInit();
  }

  ///Get Duplicate device in cart
  void getCartCheckout() {
    listCartDevice.forEach((element) {
      print(element.model);
    });
  }

  ///Get Device Data
  RxList<Device> listDeviceData = RxList([]);

  void getDeviceData() {
    DeviceService.to.getAllDevice().then((value) {
      listDeviceData.value = value.data!;
      autoDeviceId();
    });
  }

  final List<String> deviceColumns = [
    'Device Name',
    '',
    'Brand',
    '',
    'Type',
    '',
    'Model',
    '',
    'Processor',
    '',
    'Main Memory',
    '',
    'Storage',
    '',
    'Price',
    '',
    'In Stock',
    '',
    'Order'
  ];

  RxString autoDeviceIdValue = RxString('');
  List<int> listDeviceId = [];
  DateTime date = DateTime.now();

  void autoDeviceId() {
    int max = 0;
    if (listDeviceData.length == 0) {
      max = 1;
      autoDeviceIdValue.value =
          'DV${date.year.toString().substring(2)}${date.month}${max.toString().padLeft(5, '0')}';
    } else {
      for (int i = 0; i < listDeviceData.length; i++) {
        listDeviceId.add(
            int.parse(listDeviceData[i].deviceId!.toString().substring(6)));
      }
      max = listDeviceId
              .reduce((value, element) => value > element ? value : element) +
          1;
      autoDeviceIdValue.value =
          'DV${date.year.toString().substring(2)}${date.month}${max.toString().padLeft(5, '0')}';
    }
  }

  ///Add Device to cart
  RxList<Device> listCartDevice = RxList([]);

  void addDeviceToCart({required Device data}) {
    listCartDevice.add(data);
  }

  ///Device Type
  String newDeviceType = '';
  var message = ''.obs;
  String? selectedTypeValue;
  RxList<Types> listTypeValue = RxList([]);

  void getDeviceType() {
    DeviceService.to.getDeviceTypeData().then((value) {
      listTypeValue.value = value.data!;
    });
  }

  void addDeviceType(BuildContext context) {
    if (newDeviceType == '' || newDeviceType.length == 0) {
      print('Device type is empty');
      message.value = 'Device is empty';
    } else {
      DeviceService.to
          .addDeviceType(data: {'devicetype': newDeviceType}).then((value) {
        Navigator.of(context).pop();
        Fluttertoast.showToast(
            msg: 'Success',
            webPosition: 'center',
            webBgColor: 'green',
            textColor: Colors.white);
        print(value);
        getDeviceType();
      });
    }
  }

  ///Brand
  String? selectedBrandValue;
  RxList<Brand> listBrand = RxList([]);
  var newBrand = ''.obs;
  var validate = false.obs;

  void getBrandData() {
    DeviceService.to.getDataBrand().then((value) {
      listBrand.value = value.data!;
    });
  }

  void addBrand(BuildContext context) {
    print(newBrand);
    if (newBrand.value == '' || newBrand.value.length == 0) {
      validate.value = true;
    } else {
      DeviceService.to.addBrand(brand: newBrand.value).then((value) {
        print(value);
        Navigator.of(context).pop();
        Fluttertoast.showToast(
            msg: 'Successfully added new brand!!',
            webPosition: 'center',
            webBgColor: 'green',
            textColor: Colors.white);
        getBrandData();
      });
    }
  }

  TextEditingController localIDController = TextEditingController();
  TextEditingController deviceNameController = TextEditingController();
  TextEditingController computerNameController = TextEditingController();
  TextEditingController joinDomainController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController serviceTagController = TextEditingController();
  TextEditingController providerController = TextEditingController();
  TextEditingController cpuController = TextEditingController();
  TextEditingController ramController = TextEditingController();
  TextEditingController hardDiskController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  String warrantyDate = '';

  TextEditingController commentController = TextEditingController();
  TextEditingController remarkController = TextEditingController();

  void addNewDeviceData() {
    DeviceService.to
        .addDevice(
            data: DeviceModel(
      deviceId: autoDeviceIdValue.value,
      localId: localIDController.text,
      deviceName: deviceNameController.text,
      computername: computerNameController.text,
      joinDomain: joinDomainController.text,
      model: modelController.text,
      servicetagSn: serviceTagController.text,
      provider: providerController.text,
      cpus: cpuController.text,
      ram: ramController.text,
      hardisk: hardDiskController.text,
      price: priceController.text,
      warranty: warrantyDate,
      comments: commentController.text,
      remark: remarkController.text,
      // typeId: selectedTypeValue.toString(),
      // brandId: selectedBrandValue.toString(),
    ).toMap())
        .then((value) {
      print(value);
      autoDeviceId();
    });
  }

  ///Get order data
  RxList<Order> listOrder = RxList([]);

  void getOrderData() {
    OrderService.to.getOrderData().then((value) {
      listOrder.value = value.data!;
      getOrderAutoId();
    });
  }

  ///Get Auto Order Id
  var autoOrderId = ''.obs;
  List<int> listOrderId = [];

  void getOrderAutoId() {
    DateTime date = DateTime.now();
    int max = 0;
    if (listOrder.length == 0) {
      max = 1;
    } else {
      for (int i = 0; i < listOrder.length; i++) {
        listOrderId
            .add(int.parse(listOrder[i].orderId.toString().substring(6)));
      }

      max = listOrderId
              .reduce((value, element) => value > element ? value : element) +
          1;
    }
    autoOrderId.value =
        'OR${date.year.toString().substring(2)}${date.month.toString()}${max.toString().padLeft(4, '0')}';
  }
}
