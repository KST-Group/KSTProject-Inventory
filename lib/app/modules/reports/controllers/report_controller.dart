import 'package:get/get.dart';
import 'package:kst_inventory/models/report_devices.dart';
import 'package:kst_inventory/services/report_services.dart';

class ReportController extends GetxController {
  @override
  void onInit() {
    getReportDevice();
    super.onInit();
  }

  final List<String>columnData=[
    'No',
    'Device ID',
    'Device Name',
    'Computer Name',
    'Status',
    'Device Type',
    'Brand',
    'Model',
    'Service Tag/SN',
    'Processor',
    'Main Memory',
    'Storage',
    'Provider',
    'Buy Date',
    'Price',
    'Warranty',
    'Comment'
  ];

  ///GetReport Device Data
  RxList<ReportDeviceModel> listReportDevice = RxList([]);
  void getReportDevice() {
    ReportService.to.getReportDevice().then((value) {
      listReportDevice.value = value.data!;
    });
  }
}
