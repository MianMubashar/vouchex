import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:http/http.dart' as http;
import '../../ui/widgets/custom_widgets/simple_dialog.dart';

class ClaimVoucherController extends GetxController{
  var isLoading=true.obs;
  var loginDetails=GetStorage();
  
  Future requestClaimVoucher(BuildContext context, int? requester_voucher_id) async{
    isLoading.value= true;
    var token=loginDetails.read('token');
    try {
      Uri url = Uri.parse('$baseUrl/voucher-give-away');
      var header={
        "Content-Type": "application/json",
        'Accept': 'application/json',
        "Authorization" : "Bearer $token"
      };
      var bodyData={
        'requester_voucher_id':requester_voucher_id
      };
      var body=jsonEncode(bodyData);
      var response=await http.post(url,headers: header,body: body);
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        Map<String, dynamic> apiResponse = json.decode(response.body);
        bool status = apiResponse['status'];
        if (status) {
          isLoading.value = false;
          Get.back();
          ImageDialog(
              title: '${apiResponse['message']}',
              imageUrl: 'assets/images/congrats_img.png')
              .show(context);
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