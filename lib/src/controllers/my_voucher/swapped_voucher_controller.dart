import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/data/services/services.dart';

class MySwappedVoucherController extends GetxController{

  var swappedVoucherList = <SwappedVouchersList>[].obs;
  int currentPage = 1;
  late int totalPages;
  final RefreshController refreshController = RefreshController(initialRefresh: true);
  var isLoading = false.obs;
  var loginDetails = GetStorage();

  Future<bool> getMySwappedVouchers({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 1;
    } else {
      if (currentPage >= totalPages) {
        refreshController.loadNoData();
        return false;
      }
    }
    var token = loginDetails.read("token");
    debugPrint("This is token $token");
    isLoading.value == true;
    var response = await GetDataFromAPI.fetchData("$baseUrl/my-swapped-vouchers", token);
    if (response != null) {
      final result = mySwappedVouchersModelFromJson(response);
      if (isRefresh) {
        if(result.swappedVouchers != null) {
          swappedVoucherList.value = result.swappedVouchers!.data!;
        }
      }else{
        swappedVoucherList.addAll(result.swappedVouchers!.data!);
      }
      currentPage++;
      totalPages = result.swappedVouchers!.total;
      isLoading.value = false;
      return true;
    } else {
      return false;
    }
  }
}