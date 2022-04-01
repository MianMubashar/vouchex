import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/data/services/services.dart';

class MySwappedVoucherController extends GetxController{
  List<VoucherHistoryData>? swappedVoucherList = [];
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
      final result = voucherHistoryModelFromJson(response);
      if (isRefresh) {
        if(result.vouchers != null) {
          swappedVoucherList = result.vouchers!.data;
        }

      }else{
        if(result.vouchers != null) {
          swappedVoucherList!.addAll(result.vouchers!.data!);
        }
      }
      currentPage++;
      if(result.vouchers != null) {
        totalPages = result.vouchers!.total;
      }
      isLoading.value = false;
      return true;
    } else {
      return false;
    }
  }
}