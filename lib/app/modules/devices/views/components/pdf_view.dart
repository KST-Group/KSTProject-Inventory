import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/devices/controllers/device_controller.dart';
import 'package:flutter/material.dart';
import 'package:kst_inventory/models/device.dart';
import 'package:kst_inventory/utils/constants.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfView extends GetView<DeviceController> {
  @override
  Widget build(BuildContext context) {
    if (controller.deviceDataById.length==0) {
      return CircularProgressIndicator();
    }
    Device device = Device();
    controller.deviceDataById.forEach((element) {
      device = element;
    });
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      child: PdfPreview(
        build: (format) => _generatePdf(format, 'Pdf',device),
      ),
    );
  }

  _deviceData({required String title, required String data, PdfColor? color}) {
    return pw.Container(
      color: color,
      padding: pw.EdgeInsets.all(10),
      child: pw.Row(
        children: [
          pw.Container(
            child: pw.Text('$title'),
            width: 200,
          ),
          pw.Text('$data'),
        ],
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, String? title,Device device ) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.nunitoExtraLight();
    pdf.addPage(pw.Page(
      pageFormat: format,
      build: (context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Device Specifications'),
            pw.Divider(),
            _deviceData(
              title: 'Device ID',
              data: '${device.localId}',
              color: PdfColor.fromHex('#ECECEC'),
            ),
            _deviceData(
              title: 'Device Name',
              data: '${device.deviceName}',
              //color: PdfColor.fromHex('#ECECEC'),
            ),
            _deviceData(
              title: 'Join Domain',
              data: '${device.joinDomain}',
              color: PdfColor.fromHex('#ECECEC'),
            ),
            _deviceData(
              title: 'Status',
              data: device.statuss.toString(),
            ),
            _deviceData(
              title: 'Using by',
              data:
              controller.employeeName.value,
              color: PdfColor.fromHex('#ECECEC'),
            ),
            _deviceData(
              title: 'Device Type',
              data:
              device.deviceType.toString(),
            ),
            _deviceData(
              title: 'Brand',
              data: device.brand.toString(),
              color: PdfColor.fromHex('#ECECEC'),
            ),
            _deviceData(
              title: 'Model',
              data: device.model.toString(),
            ),
            _deviceData(
              title: 'Service Tag/SN',
              data: device.servicetagSn
                  .toString(),
              color: PdfColor.fromHex('#ECECEC'),
            ),
            _deviceData(
              title: 'Processor',
              data: device.cpus.toString(),
            ),
            _deviceData(
              title: 'Main Memory',
              data: device.ram.toString(),
              color: PdfColor.fromHex('#ECECEC'),
            ),
            _deviceData(
              title: 'Storage',
              data: device.hardisk.toString(),
            ),
            _deviceData(
              title: 'Warranty',
              data: device.expireDate ?? '--',
              color: PdfColor.fromHex('#ECECEC'),
            ),

          ],
        );
      },
    ));
    return pdf.save();
  }
}
