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
  late int totalPages;
  final RefreshController peRefreshController = RefreshController(initialRefresh: true);
  var isLoading = false.obs;
  var noData = ''.obs;
  var loginDetails = GetStorage();

  Future<bool> getPendingExchangeRequest({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 1;
    } else {
      if (currentPage >= totalPages) {
        peRefreshController.loadNoData();
        return false;
      }
    }
    var token = loginDetails.read("token");
    debugPrint("This is token $token");
    isLoading.value == true;
    var response = await GetDataFromAPI.fetchData("$baseUrl/get-pending-exchange-requests", token);
    if (response != null) {
      final result = pendingExchangeRequestModelFromJson(response);
      if(result.pendingExchangeRequests!.data!.isEmpty) {
        noData.value = 'No request';
      }
      if (isRefresh) {
        requesterVoucher.value = result.pendingExchangeRequests!.data!;
      }else{
        requesterVoucher.addAll(result.pendingExchangeRequests!.data!);
      }
      if(result.pendingExchangeRequests!.nextPageUrl != null) {
        currentPage++;
      }
      totalPages = currentPage;
      isLoading.value = false;
      return true;
    } else {
      return false;
    }
  }

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
          getPendingExchangeRequest(isRefresh: true);
          voucherStatus == "accept" ? Get.snackbar("Accepted",
              "${apiResponse['message']}", colorText: blackText, icon: const Icon(Icons.verified_outlined, color: Colors.black,),backgroundColor: Colors.white) :
          Get.snackbar("Decline", "${apiResponse['message']}",
              colorText: primaryColor, icon: const Icon(Icons.cancel, color: primaryColor,),backgroundColor: Colors.white);
          if (kDebugMode) {
            print('message is ${apiResponse['message']}');
          }
          //Get.back();
        }else{
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


  static const _pageSize = 15;

  final PagingController<int, PEData> pagingController = PagingController(firstPageKey: 1);

  Future<void> fetchPage(int pageKey) async {
    try {
      var token = loginDetails.read("token");
      debugPrint("This is token $token");
      isLoading.value == true;
      var response = await GetDataFromAPI.fetchData(
          "$baseUrl/get-pending-exchange-requests", token);
      if (response != null) {
        final result = pendingExchangeRequestModelFromJson(response);
        if (result.pendingExchangeRequests!.data!.isEmpty) {
          noData.value = 'No request';
        }
        requesterVoucher.value = result.pendingExchangeRequests!.data!;
        final isLastPage = requesterVoucher.length < _pageSize;

        if (isLastPage) {
          pagingController.appendLastPage(requesterVoucher);
        } else {
          final nextPageKey = pageKey + requesterVoucher.length;
          pagingController.appendPage(requesterVoucher, nextPageKey);
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
      fetchPage(pageKey);
    });
    super.onInit();
  }
}