import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/models/brand.dart';
import 'package:kst_inventory/models/device.dart';
import 'package:kst_inventory/models/device_model.dart';
import 'package:kst_inventory/models/device_type.dart';
import 'package:kst_inventory/models/using_device.dart';
import 'package:kst_inventory/services/checkout_services.dart';
import 'package:kst_inventory/services/device_services.dart';

class DeviceController extends GetxController {
  //Global
  var loading = false.obs;
  final List<String> deviceColumns = [
    'No',
    '',
    'Device ID',
    '',
    'Device Type',
    '',
    'Status',
    '',
    'Join Domain',
    '',
    'Brand',
    '',
    'Model',
    '',
    'Service Tag/SN',
    '',
    'Computer Name',
    '',
    'Processor',
    '',
    'Main Memory',
    '',
    'Storage',
    '',
    'Action',
  ];

  @override
  void onInit() {
    ///Field

    ///Methods
    getDeviceType();
    getBrandData();

    ///Devices
    getDevice();
    super.onInit();
  }

  ///Get DeviceBy Id
  RxList<Device> deviceDataById = RxList([]);

  void getDeviceById({required String deviceId}) {
    DeviceService.to.getDeviceById(deviceId: deviceId).then((value) {
      deviceDataById.value = value.data!;
    });
  }

  ///Search Box
  TextEditingController searchController = TextEditingController();
  var searchText = ''.obs;
  RxList<Device> listSearch = RxList([]);

  void onSearchDevice() {
    String search = searchText.value.toString().toLowerCase().trim();
    listSearch.value = listDevice.where((device) {
      String name = device.deviceName.toString().toLowerCase().trim();
      String deviceId = device.deviceId.toString().toLowerCase().trim();
      String localId = device.localId.toString().toLowerCase().trim();
      String model = device.model.toString().toLowerCase().trim();
      String type = device.deviceType.toString().toLowerCase().trim();
      String brand = device.brand.toString().toLowerCase().trim();

      return name.contains(search) ||
          deviceId.contains(search) ||
          localId.contains(search) ||
          model.contains(search) ||
          type.contains(search) ||
          brand.contains(search);
    }).toList();
    print(listSearch.length);
  }

  //////////////////////////////////////////////////////////////////////
  ///Filter Device

  /////////////////// Add Device
  ///Auto_ID
  RxString autoDeviceIdValue = RxString('');
  List<int> listDeviceId = [];
  DateTime date = DateTime.now();

  void autoDeviceId() {
    int max = 0;
    if (listDevice.length == 0) {
      max = 1;
      autoDeviceIdValue.value =
          'DV${date.year.toString().substring(2)}${date.month}${max.toString().padLeft(5, '0')}';
    } else {
      for (int i = 0; i < listDevice.length; i++) {
        listDeviceId
            .add(int.parse(listDevice[i].deviceId!.toString().substring(6)));
      }
      max = listDeviceId
              .reduce((value, element) => value > element ? value : element) +
          1;
      autoDeviceIdValue.value =
          'DV${date.year.toString().substring(2)}${date.month}${max.toString().padLeft(5, '0')}';
    }
  }

  ///Brand
  RxList<Brand> listBrand = RxList([]);
  String? selectedBrandValue;

  void getBrandData() {
    DeviceService.to.getDataBrand().then((value) {
      listBrand.value = value.data!;
    });
  }

  var newBrand = ''.obs;
  var validate = false.obs;

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

  ///Add Device type
  RxList<Types> listType = RxList([]);
  String? selectedTypeValue;
  void getDeviceType() {
    DeviceService.to.getDeviceTypeData().then((value) {
      listType.value = value.data!;
    });
  }

  String newDeviceType = '';
  var message = ''.obs;

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

  ///Get all devices
  RxList<Device> listDevice = RxList([]);

  Future getDevice() async {
    DeviceService.to.getAllDevice().then((value) {
      listDevice.value = value.data!;
      autoDeviceId();
    });
  }

  ///Add new Device
  ///Device
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

  void addNewDeviceData(BuildContext context) {
    if (selectedTypeValue == null || selectedTypeValue == '') {
      print('Select device type');
    } else {
      loading.value = true;
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
        typeId: selectedTypeValue.toString(),
        brandId: selectedBrandValue.toString(),
      ).toMap())
          .then((value) {
            selectedBrandValue=null;
            selectedTypeValue=null;
        Navigator.of(context).pop();
        loading.value = false;
        autoDeviceId();
        getDevice();
      });
    }
  }

  ///Delete Device
  void deleteDeviceById({required String deviceId}) {
    DeviceService.to.deleteDevice(deviceId: deviceId).then((value) {
      getDevice();
      Get.rootDelegate.popRoute().then((value) => Get.rootDelegate.popRoute());
      Fluttertoast.showToast(msg: 'Success',webPosition: 'center');
    });
  }

  ///Get Using device
  RxList<Using> listUsing = RxList([]);
  var employeeName = ''.obs;

  void usingByEmployee({required String data}) {
    DeviceService.to.useDevice().then(
      (value) {
        listUsing.value = value.data!.where((element) {
          String deviceId = element.deviceId.toString();
          return deviceId.contains(data);
        }).toList();
        if (listUsing.length == 0) {
          employeeName.value = 'None';
        } else {
          employeeName.value = listUsing[0].nameEn.toString();
        }
      },
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    localIDController.dispose();
    deviceNameController.dispose();
    computerNameController.dispose();
    joinDomainController.dispose();
    modelController.dispose();
    serviceTagController.dispose();
    providerController.dispose();
    cpuController.dispose();
    ramController.dispose();
    hardDiskController.dispose();
    priceController.dispose();
    commentController.dispose();
    remarkController.dispose();
    super.dispose();
  }
}
