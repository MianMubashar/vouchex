import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vouchex/src/data/model/models.dart';

import '../../data/constants.dart';
import '../../data/services/api/fetch_data.dart';
import 'package:http/http.dart' as http;

import '../../ui/widgets/custom_widgets/simple_dialog.dart';

class RequestVoucherExchangeController extends GetxController{
  var isLoading = false.obs;
  var loginDetails = GetStorage();
  var currentPage = 1;
  late int totalPages;
  var myVouchersList = <MyVouchersData>[].obs;
  var noData = ''.obs;

  var to = 0.obs;
  var total = 0.obs;

  final RefreshController refreshController = RefreshController(initialRefresh: true);

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
     Map<String, dynamic> apiResponse = jsonDecode(response.body);
     bool status = apiResponse['status'];
     if(status){
       isLoading.value=false;
       //Get.snackbar("", "${apiResponse['message']}", colorText: blackText, icon: const Icon(Icons.verified_outlined, color: Colors.black,),backgroundColor: Colors.white);
       Get.back();
       ImageDialog(
               title: '${apiResponse['message']}',
               imageUrl: 'assets/images/congrats_img.png')
           .show(context);
       if (kDebugMode) {
         print('message is ${apiResponse['message']}');
       }
       //Get.back();
     }else{
       isLoading.value=false;
       Get.snackbar("${apiResponse['message']}", "", colorText: blackText, icon: const Icon(Icons.verified_outlined, color: Colors.black,),backgroundColor: Colors.white);
       if (kDebugMode) {
         print('message is ${apiResponse['message']}');
       }
     }
   }else{
     isLoading.value=false;
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

  Future<bool> getMyVouchers({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 1;
    } else {
      if (to.value >= total.value) {
        refreshController.loadNoData();
        return false;
      }
    }
    var token = loginDetails.read("token");
    debugPrint("This is token $token");
    isLoading.value == true;
    var response = await GetDataFromAPI.fetchData("$baseUrl/my-vouchers?page=$currentPage", token);
    if (response != null) {
      final result = myVouchersFromJson(response);
      total.value = result.vouchers!.total;
      to.value = result.vouchers!.to!;
      if (isRefresh) {
        if(result.vouchers != null) {
          myVouchersList.value = result.vouchers!.data!;
          if(result.vouchers!.data!.isEmpty) {
            noData.value = 'No data exists';
          }
        }
      }else{
        if(result.vouchers != null) {
          myVouchersList.addAll(result.vouchers!.data!);
        }
      }
      currentPage++;
      totalPages = result.vouchers!.total;
      isLoading.value = false;
      return true;
    } else {
      return false;
    }
  }
}