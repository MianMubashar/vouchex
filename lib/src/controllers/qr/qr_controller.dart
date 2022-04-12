import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';

class QrController extends GetxController{
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  var isLoading = false.obs;
  final loginDetails = GetStorage();

  TextEditingController qrResult = TextEditingController();

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      result = scanData;
      qrResult.text = result!.code.toString();
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future redeemVoucher() async {
    isLoading.value = true;
    Map data = {
      'uu_id' : qrResult.text,
    };
    var token = loginDetails.read("token");
    var body = json.encode(data);
    var response = await http.post(Uri.parse('$baseUrl/redeem-voucher'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          "Authorization" : "Bearer $token"
        },
        body: body
    );
    isLoading.value = false;
    if(response.statusCode == 200) {
      print(response.body);
      ImageDialog(
          imageUrl: 'assets/images/congrats_img.png',
          title: 'Congratulations\nYou Get 10% discount'
      ).show(Get.context);
      return response.body;
    } else {
      return print(response.body);
    }
  }

}