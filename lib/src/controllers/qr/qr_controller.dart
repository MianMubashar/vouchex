import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrController extends GetxController{
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  var code = ''.obs;
  QRViewController? controller;

  TextEditingController qrResult = TextEditingController();

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      result = scanData;
      code.value = result!.code.toString();
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

}