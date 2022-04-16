import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/data/services/services.dart';

class MyRedeemedVoucherController extends GetxController {
  List<SwappedVouchersList>? redeemedVouchersList = [];
  int currentPage = 1;
  int totalPages = 1;
  final RefreshController refreshController = RefreshController(initialRefresh: true);
  var isLoading = false.obs;
  var noData = ''.obs;
  var loginDetails = GetStorage();

  Future<bool> getMyRedeemedVouchers({bool isRefresh = false}) async {
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
    var response = await GetDataFromAPI.fetchData("$baseUrl/my-redeemed-voucher", token);
    if (response != null) {
      final result = mySwappedVouchersModelFromJson(response);
      if(result.swappedVouchers!.data!.isEmpty) {
        noData.value = 'No Data';
      }
      if (isRefresh) {
        if(result.swappedVouchers != null) {
          redeemedVouchersList = result.swappedVouchers!.data;
        }

      }else{
        if(result.swappedVouchers != null) {
          redeemedVouchersList!.addAll(result.swappedVouchers!.data!);
        }
      }
      currentPage++;
      if(result.swappedVouchers != null) {
        totalPages = result.swappedVouchers!.total;
      }
      isLoading.value = false;
      return true;
    } else {
      return false;
    }
  }
}