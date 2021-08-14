import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/models/brand.dart';
import 'package:kst_inventory/models/device_type.dart';
import 'package:kst_inventory/services/device_services.dart';

class DeviceController extends GetxController {
  var dropdownValue = 'One'.obs;
  var dropdownType = '1'.obs;
  List<Types> listType = [];

  ///Device
  var deviceId;
  TextEditingController? deviceName;
  TextEditingController? status;
  TextEditingController? comment;
  TextEditingController? joinDomain;
  TextEditingController? model;
  TextEditingController? serviceTag;
  TextEditingController? localID;
  TextEditingController? computerName;
  TextEditingController? cpu;
  TextEditingController? ram;
  TextEditingController? hardDisk;
  TextEditingController? provider;
  TextEditingController? price;

  @override
  void onInit() {
    ///Field
    brand = TextEditingController();
    deviceType = TextEditingController();

    ///Methods
    getDeviceType();
    getBrandData();
    super.onInit();
  }

  ///Brand
  TextEditingController? brand;
  var dropdownBrand = '1'.obs;
  List<Brand> listBrand = [];

  onChangeBrand(String value) {
    dropdownBrand.value = value;
  }

  Future getBrandData() async {
    DeviceService.to.getData().then((value) {
      Brands brands = value;
      listBrand = brands.data!;
      print(listBrand.length);
    });
  }

  Future addBrand() async {
    if (brand!.text == '' || brand!.text.length == 0) {
      print('Input your brand data');
    } else {
      DeviceService.to.addBrand(brand: brand!.text).then((value) {
        getBrandData();
        print(value);
      });
    }
  }

  ///Add Device Type
  TextEditingController? deviceType;

  onChangedValue(String value) {
    dropdownValue.value = value;
  }

  onChangeType(String? value) {
    dropdownType.value = value!;
  }

  ///DeviceType
  Future getDeviceType() async {
    DeviceService.to.getDeviceTypeData().then((value) {
      DeviceType deviceType = value;
      listType = deviceType.data!;
      print(listType.length);
    });
  }

  ///Add Device type
  Future addDeviceType() async {
    if (deviceType!.text == '' || deviceType!.text.length == 0) {
      print('Device is empty');
    } else {
      DeviceService.to
          .addDeviceType(deviceType: deviceType!.text)
          .then((value) {
        getDeviceType();
        print(value);
      });
    }
  }
}
