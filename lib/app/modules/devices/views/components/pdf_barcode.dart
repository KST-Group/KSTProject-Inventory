import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kst_inventory/app/modules/devices/controllers/device_controller.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class PdfBarCode extends GetView<DeviceController> {
  final code;
  PdfBarCode({required this.code});

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final pdf = pw.Document();
    format = PdfPageFormat.roll80;
    pdf.addPage(pw.Page(
      orientation: pw.PageOrientation.portrait,
      pageFormat: format,
      build: (context) {
        return pw.Container(
            child: pw.Center(
          child: pw.Column(
            mainAxisSize: pw.MainAxisSize.min,
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.BarcodeWidget(
                color: PdfColor.fromHex("#000000"),
                data: '$code',
                barcode: pw.Barcode.code128(),
                width: 120,
                height: 40,
              )
            ],
          ),
        ));
      },
    ));
    return pdf.save();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      child: PdfPreview(
        build: (format) => _generatePdf(format),
      ),
    );
  }
}
