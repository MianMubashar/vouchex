import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/data/services/api/fetch_data.dart';

class FreeVoucherController extends GetxController{
  var freeVoucherList = <MyVouchersData>[].obs;
  int currentPage = 1;
  late int totalPages;
  final RefreshController refreshController = RefreshController(initialRefresh: true);
  var isLoading = false.obs;
  var loginDetails = GetStorage();
  var noData = ''.obs;

  Future<bool> getFreeVouchers({bool isRefresh = false}) async {
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
    var response = await GetDataFromAPI.fetchData("$baseUrl/rewarded-vouchers?page=$currentPage", token);
    if (response != null) {
      final result = myVouchersFromJson(response);
      if (isRefresh) {
        if(result.vouchers != null) {
          freeVoucherList.value = result.vouchers!.data!;
          if(freeVoucherList.isEmpty) {
            noData.value = "No data exists";
          }
        }
      }else{
        if(result.vouchers != null) {
          freeVoucherList.addAll(result.vouchers!.data!);
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