import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/data/services/services.dart';

import '../../data/constants.dart';
import '../../data/model/voucher/my_swapped_vouchers_model.dart';

class SentPendingRequestController  extends GetxController {
  var sentPendingRequestList = <SwappedVouchersList>[].obs;
  int currentPage = 1;
  late int totalPages;
  final RefreshController refreshController = RefreshController(initialRefresh: true);
  var isLoading = false.obs;
  var loginDetails = GetStorage();
  var noData = ''.obs;

  var to = 0.obs;
  var total = 0.obs;

  Future<bool> getSentPendingRequests({bool isRefresh = false}) async {
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
    var response = await GetDataFromAPI.fetchData("$baseUrl/get-sent-pending-exchange-request?page=$currentPage", token);
    if (response != null) {
      final result = mySwappedVouchersModelFromJson(response);

      total.value = result.swappedVouchers!.total;
      to.value = result.swappedVouchers!.to!;

      if (isRefresh) {
        if(result.swappedVouchers != null) {
          sentPendingRequestList.value = result.swappedVouchers!.data!;
          if(sentPendingRequestList.isEmpty) {
            noData.value = "No data exists";
          }
        }
      }else{
        if(result.swappedVouchers != null) {
          sentPendingRequestList.addAll(result.swappedVouchers!.data!);
        }
      }
      currentPage++;
      total.value = result.swappedVouchers!.total;
      isLoading.value = false;
      return true;
    } else {
      return false;
    }
  }
}