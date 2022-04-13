import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../data/constants.dart';
import '../../data/services/api/fetch_data.dart';
import 'package:http/http.dart' as http;

import '../../ui/widgets/custom_widgets/simple_dialog.dart';

class RequestVoucherExchangeController extends GetxController{
  var isLoading = false.obs;
  var loginDetails = GetStorage();


  Future requestVoucherExchange(BuildContext context,int? requester_voucher_id,int? requestee_id,int? requestee_voucher_id) async{
    var token = loginDetails.read("token");
    debugPrint("This is token $token");
    isLoading.value == true;
    try{
   var url=Uri.parse('$baseUrl/request-swap');
   var header={
     "Content-Type": "application/json",
     'Accept': 'application/json',
     "Authorization" : "Bearer $token"
   };

   var bodyData={
     'requester_voucher_id':requester_voucher_id,
     'requestee_id':requestee_id,
     'requestee_voucher_id':requestee_voucher_id
   };
   var body=jsonEncode(bodyData);
   var response=await http.post(url,headers: header,body: body);
   if(response.statusCode == 200 && response.body.isNotEmpty){
     Map<String, dynamic> apiResponse=jsonDecode(response.body);
     bool status=apiResponse['status'];
     if(status){
       isLoading.value=false;
       //Get.snackbar("", "${apiResponse['message']}", colorText: blackText, icon: const Icon(Icons.verified_outlined, color: Colors.black,),backgroundColor: Colors.white);
       Get.back();
       ImageDialog(
               title:
                   '${apiResponse['message']}',
               imageUrl: 'assets/images/congrats_img.png')
           .show(context);
       print('message is ${apiResponse['message']}');
       //Get.back();
     }else{
       isLoading.value=false;
       Get.snackbar("", "${apiResponse['message']}", colorText: blackText, icon: const Icon(Icons.verified_outlined, color: Colors.black,),backgroundColor: Colors.white);
       print('message is ${apiResponse['message']}');
     }
   }else{
     isLoading.value=false;
     print('error from request voucher exchange');

   }
    }catch(e){
      isLoading.value=false;
      print('try catch error from request voucher exchange controller ${e}');

    }


  }
}