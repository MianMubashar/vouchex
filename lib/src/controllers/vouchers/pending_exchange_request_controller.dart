import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vouchex/src/data/model/voucher/pending_exchange_request.dart';
import 'package:vouchex/src/data/services/services.dart';
import '../../data/constants.dart';

class PendingExchangeRequestController extends GetxController {
  var requesterVoucher = <PEData>[].obs;
  int currentPage = 1;
  late int totalPages;
  final RefreshController refreshController = RefreshController(initialRefresh: true);
  var isLoading = false.obs;
  var noData = ''.obs;
  var loginDetails = GetStorage();

  Future<bool> getPendingExchangeRequest({bool isRefresh = false}) async {
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
    var response = await GetDataFromAPI.fetchData("$baseUrl/get-pending-exchange-requests", token);
    if (response != null) {
      final result = pendingExchangeRequestModelFromJson(response);
      if (isRefresh) {
        requesterVoucher.value = result.pendingExchangeRequests!.data!;
      }else{
        requesterVoucher.addAll(result.pendingExchangeRequests!.data!);
      }
      currentPage++;
      totalPages = result.pendingExchangeRequests!.total!;
      isLoading.value = false;
      return true;
    } else {
      return false;
    }
  }
}