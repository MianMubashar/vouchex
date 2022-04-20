import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/data/services/api/fetch_data.dart';
import 'package:http/http.dart' as http;

import '../../ui/widgets/custom_widgets/simple_dialog.dart';

class CancelSentPendingRequestVoucher extends GetxController{
var isLoading=false.obs;
var loginDetails=GetStorage();

Future requestCancelSentPendingRequestVoucher(BuildContext context,int? exchange_request_id,String? status) async {
  var token = loginDetails.read('token');
  isLoading.value = true;
  try {
    Uri url=Uri.parse(baseUrl+'/cancel-exchange-request');
    var header={
      "Content-Type": "application/json",
      'Accept': 'application/json',
      "Authorization" : "Bearer $token"
    };
    var bodyData={
      'exchange_request_id':exchange_request_id,
      'status':status
    };
    var body=jsonEncode(bodyData);
    var response=await http.post(url,headers: header,body: body);
    if (response.statusCode==200) {
      Map<String, dynamic> apiResponse = jsonDecode(response.body);
      bool status = apiResponse['status'];
      if (status) {
        isLoading.value = false;
        Get.back();
        // ImageDialog(
        //     title: '${apiResponse['message']}',
        //     imageUrl: 'assets/images/congrats_img.png')
        //     .show(context);
      } else {
        isLoading.value = false;
        Get.snackbar("${apiResponse['message']}", "", colorText: blackText,
            icon: const Icon(Icons.verified_outlined, color: Colors.black,),
            backgroundColor: Colors.white);
        if (kDebugMode) {
          print('message is ${apiResponse['message']}');
        }
      }
    } else {
      isLoading.value = false;
      if (kDebugMode) {
        print('error from request voucher exchange');
      }
    }
  }catch(e){
    isLoading.value=false;
    if (kDebugMode) {
      print('try catch error from request voucher exchange controller $e');
    }
  }
}
}