import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:get_storage/get_storage.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/data/services/services.dart';

class GetAllVouchersController extends GetxController {

  var vouchersList = <AllVouchersData>[].obs;
  int currentPage = 1;
  late int totalPages;
  //final RefreshController vouchersRefreshController = RefreshController(initialRefresh: true);
  var isLoading = false.obs;
  var noData = ''.obs;
  var loginDetails = GetStorage();

  /*Future<bool> getAllVouchersDataData({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 1;
    } else {
      if (currentPage >= totalPages) {
        vouchersRefreshController.loadNoData();
        return false;
      }
    }
    var token = loginDetails.read("token");
    debugPrint("This is token $token");
    isLoading.value == true;
    var response = await GetDataFromAPI.fetchData("$baseUrl/get-all-vouchers", token);
    if (response != null) {
      final result = getAllVouchersFromJson(response);
      if(result.vouchers!.data!.isEmpty) {
        noData.value = "No data exists";
      }
      if (isRefresh) {
        vouchersList.value = result.vouchers!.data!;
      }else{
        vouchersList.addAll(result.vouchers!.data!);
      }
      if(result.vouchers!.nextPageUrl != null) {
        currentPage++;
      }
      totalPages = currentPage;
      isLoading.value = false;
      return true;
    } else {
      return false;
    }
  }*/

  static const _pageSize = 15;

  final PagingController<int, AllVouchersData> pagingController = PagingController(firstPageKey: 0);

  Future<void> fetchPage(int pageKey) async {
    try {
      var token = loginDetails.read("token");
      debugPrint("This is token $token");
      isLoading.value == true;
      var response = await GetDataFromAPI.fetchData(
          "$baseUrl/get-all-vouchers", token);
      if (response != null) {
        final result = getAllVouchersFromJson(response);
        if (result.vouchers!.data!.isEmpty) {
          noData.value = 'No request';
        }
        vouchersList.value = result.vouchers!.data!;
        final isLastPage = vouchersList.length <= _pageSize;

        if (isLastPage) {
          pagingController.appendLastPage(vouchersList);
        } else {
          final nextPageKey = pageKey + vouchersList.length;
          pagingController.appendPage(vouchersList, nextPageKey);
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