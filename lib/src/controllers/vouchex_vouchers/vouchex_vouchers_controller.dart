import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/data/services/services.dart';


class VouchexVouchersController extends GetxController {
  var vouchexList = <VouchersData>[].obs;
  int currentPage = 1;
  late int totalPages;
  final RefreshController refreshController = RefreshController(initialRefresh: true);
  var isLoading = false.obs;
  var loginDetails = GetStorage();
  var noData = ''.obs;

  var to = 0.obs;
  var total = 0.obs;

  Future<bool> getVouchexData({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 1;
    } else {
      if (to.value >= total.value) {
        refreshController.loadNoData();
        return false;
      }
    }
    var token = loginDetails.read("token");
    debugPrint("//////////////token: $token");
    isLoading.value == true;
    var response = await GetDataFromAPI.fetchData("$baseUrl/get-vouchex-vouchers", token);
    if (response != null) {
      final result = vouchexModelFromJson(response);
      total.value = result.vouchexVouchers.total;
      to.value = result.vouchexVouchers.to!;
      if(result.vouchexVouchers.data.isEmpty) {
        noData.value = "No Data exist";
      }
      if (isRefresh) {
        vouchexList.value = result.vouchexVouchers.data;
      }else{
        vouchexList.addAll(result.vouchexVouchers.data);
      }
      currentPage++;
      totalPages = result.vouchexVouchers.total;
      isLoading.value = false;
      return true;
    } else {
      return false;
    }
  }
}