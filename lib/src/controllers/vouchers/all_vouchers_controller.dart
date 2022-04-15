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

  var perPage = 0.obs;
  var listSize = 0.obs;


  final PagingController<int, AllVouchersData> pagingController = PagingController(firstPageKey: 0);

  Future<void> fetchVouchers(int pageKey) async {
    try {
      var token = loginDetails.read("token");
      debugPrint("This is token $token");
      isLoading.value == true;
      var response = await GetDataFromAPI.fetchData("$baseUrl/get-all-vouchers?page=$currentPage", token);
      if (response != null) {
        final result = getAllVouchersFromJson(response);

        vouchersList.value = result.vouchers!.data!;
        perPage.value = result.vouchers!.perPage!;
        listSize.value = result.vouchers!.total!;

        final isLastPage = vouchersList.length < perPage.value;
        if (isLastPage) {
          pagingController.appendLastPage(vouchersList);
        } else {
          currentPage++;
          var nextPageKey = currentPage;
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
      fetchVouchers(pageKey);
    });
    super.onInit();
  }
}