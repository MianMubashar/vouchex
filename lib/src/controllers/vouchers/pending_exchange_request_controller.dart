import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vouchex/src/data/model/voucher/pending_exchange_request.dart';
import 'package:vouchex/src/data/services/services.dart';
import '../../data/constants.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PendingExchangeRequestController extends GetxController {
  var requesterVoucher = <PEData>[].obs;
  int currentPage = 1;
  var isLoading = false.obs;
  var noData = ''.obs;
  var loginDetails = GetStorage();

  var perPage = 0.obs;
  var listSize = 0.obs;


  Future updateRequestStatus(int id, String voucherStatus) async{
    var token = loginDetails.read("token");
    debugPrint("This is token $token");
    try{
      var url = Uri.parse('$baseUrl/update-exchange-request-status');
      var header={
        "Content-Type": "application/json",
        'Accept': 'application/json',
        "Authorization" : "Bearer $token"
      };

      var bodyData = {
        'exchange_request_id': id,
        'status': voucherStatus,
      };
      var body = jsonEncode(bodyData);
      var response = await http.post(url,headers: header, body: body);
      if(response.statusCode == 200 && response.body.isNotEmpty){
        if (kDebugMode) {
          print(' is ${response.statusCode}');
        }
        Map<String, dynamic> apiResponse = jsonDecode(response.body);
        bool status = apiResponse['status'];
        if(status){
          Get.back();
          await fetchPendingRequests(isRefresh: true);
          voucherStatus == "accept" ? Get.snackbar("Accepted",
              "${apiResponse['message']}", colorText: blackText, icon: const Icon(Icons.verified_outlined, color: Colors.black,),backgroundColor: Colors.white) :
          Get.snackbar("Decline", "${apiResponse['message']}",
              colorText: primaryColor, icon: const Icon(Icons.cancel, color: primaryColor,),backgroundColor: Colors.white);
          if (kDebugMode) {
            print('message is ${apiResponse['message']}');
          }
          //Get.back();
        }else{
          isLoading.value=false;
          if(apiResponse.containsKey("message")){
            Get.snackbar("Error", apiResponse['message']);
          }
          if (kDebugMode) {
            print('message is ${apiResponse['message']}');
          }
        }
      }else{
        isLoading.value=false;
        Get.snackbar("Error", "Something Went Wrong");
        if (kDebugMode) {
          print('error from request voucher exchange');
        }

      }
    }catch(e){
      isLoading.value=false;
      Get.snackbar("Error", "Something Went Wrong");
      if (kDebugMode) {
        print('try catch error from request voucher exchange controller $e');
      }

    }
  }


  final PagingController<int, PEData> pagingController = PagingController(firstPageKey: 0);


  Future<void> fetchPendingRequests({bool isRefresh = false}) async {
    try {
      var token = loginDetails.read("token");
      debugPrint("This is token $token");
      isLoading.value == true;

      if(isRefresh) {
        pagingController.itemList!.length = 0;
        requesterVoucher.length = 0;
        currentPage = 1;
        var response = await GetDataFromAPI.fetchData("$baseUrl/get-pending-exchange-requests?page=$currentPage", token);
        if (response != null) {

          final result = pendingExchangeRequestModelFromJson(response);

          requesterVoucher.value = result.pendingExchangeRequests!.data!;
          perPage.value = result.pendingExchangeRequests!.perPage!;
          listSize.value = result.pendingExchangeRequests!.total!;

          final isLastPage = requesterVoucher.length == result.pendingExchangeRequests!.to;
          if (isLastPage) {
            pagingController.appendLastPage(requesterVoucher);
          } else {
            currentPage++;
            var nextPageKey = currentPage;
            pagingController.appendPage(requesterVoucher, nextPageKey);
          }
        }
      } else {
        var response = await GetDataFromAPI.fetchData("$baseUrl/get-pending-exchange-requests?page=$currentPage", token);
        if (response != null) {

          final result = pendingExchangeRequestModelFromJson(response);

          requesterVoucher.value = result.pendingExchangeRequests!.data!;
          perPage.value = result.pendingExchangeRequests!.perPage!;
          listSize.value = result.pendingExchangeRequests!.total!;

          final isLastPage = requesterVoucher.length == result.pendingExchangeRequests!.to;
          if (isLastPage) {
            pagingController.appendLastPage(requesterVoucher);
          } else {
            currentPage++;
            var nextPageKey = currentPage;
            pagingController.appendPage(requesterVoucher, nextPageKey);
          }
        }
      }

    } catch (e) {
      pagingController.error = e;
      if (kDebugMode) {
        print(e);
      }
    }
  }


  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) {
      fetchPendingRequests();
    });
    super.onInit();
  }
}