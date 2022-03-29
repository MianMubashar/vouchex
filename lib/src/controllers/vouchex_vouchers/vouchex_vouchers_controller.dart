import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/data/services/services.dart';


class VouchexVouchersController extends GetxController {
  List<VouchersData> vouchexList = [];
  int currentPage = 1;
  late int totalPages;
  final RefreshController refreshController = RefreshController(initialRefresh: true);
  var isLoading = false.obs;
  var loginDetails = GetStorage();

  Future<bool> getVouchexData({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 1;
    } else {
      if (currentPage >= totalPages) {
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
      if (isRefresh) {
        vouchexList = result.vouchexVouchers.data;
        print(vouchexList.length);
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