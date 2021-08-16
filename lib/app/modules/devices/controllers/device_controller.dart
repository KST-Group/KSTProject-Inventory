import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/models/brand.dart';
import 'package:kst_inventory/models/device.dart';
import 'package:kst_inventory/models/device_type.dart';
import 'package:kst_inventory/services/device_services.dart';

class DeviceController extends GetxController {
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

    ///Devices
    getDevice();
    super.onInit();
  }

  ///Search Box
  Future onSearch(String value) async{

    print(value);
    if (value.length == 0) {
      getDevice();
    } else {
      String search = value.toString().toLowerCase().trim();
      listDevice.value = listDevice.where((element) {
        String name = element.deviceName.toString().toLowerCase().trim();
        String deviceId = element.deviceId.toString().toLowerCase().trim();
        return name.contains(search) || deviceId.contains(search);
      }).toList().obs;
    }
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

  onChangeType(String? value) {
    dropdownType.value = value!;
  }

  ///DeviceType
  Future getDeviceType() async {
    DeviceService.to.getDeviceTypeData().then((value) {
      DeviceType deviceType = value;
      listType = deviceType.data!;
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

  ///Get all devices
  var filterType = '1'.obs;
  var listDevice = [].obs;

  Future getDevice() async {
    DeviceService.to.getAllDevice().then((value) {
      listDevice.value = value.data!;
    });
  }

  void onFilterType(String value) {
    filterType.value = value;
    String filter = value.toString().toLowerCase().trim();
    print(filter);
    listDevice.value = listDevice.where((element) {
      var typeId = element.typeId.toString().trim();
      return typeId.contains(filter);
    }).toList();
  }
}
