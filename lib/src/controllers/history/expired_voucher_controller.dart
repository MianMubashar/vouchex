import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/data/services/services.dart';

class ExpiredVoucherController extends GetxController {
  List<MyVouchersData>? expiredVouchersList = [];
  int currentPage = 1;
  int totalPages = 1;
  final RefreshController refreshController = RefreshController(initialRefresh: true);
  var isLoading = false.obs;
  var loginDetails = GetStorage();
  var noData = ''.obs;

  var to = 0.obs;
  var total = 0.obs;

  Future<bool> getMyExpiredVouchers({bool isRefresh = false}) async {
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
    var response = await GetDataFromAPI.fetchData("$baseUrl/my-expired-vouchers", token);
    if (response != null) {
      final result = myVouchersFromJson(response);
      total.value = result.vouchers!.total;
      to.value = result.vouchers!.to!;
      if(result.vouchers!.data!.isEmpty) {
        noData.value = 'No Data';
      }
      if (isRefresh) {
        if(result.vouchers != null) {
          expiredVouchersList = result.vouchers!.data;
        }

      }else{
        if(result.vouchers != null) {
          expiredVouchersList!.addAll(result.vouchers!.data!);
        }
      }
      currentPage++;
      total.value = result.vouchers!.total;
      isLoading.value = false;
      return true;
    } else {
      return false;
    }
  }
}