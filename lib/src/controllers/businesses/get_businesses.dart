import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/data/services/services.dart';
import '../../data/model/models.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class GetBusinessesController extends GetxController{


  var businessesList = <Datum>[].obs;
  int currentPage = 1;
  late int totalPages;
  //final RefreshController refreshController = RefreshController(initialRefresh: true);
  var isLoading = false.obs;
  var noData = ''.obs;
  var loginDetails = GetStorage();

  /*Future<bool> getBusinessesData({bool isRefresh = false}) async {
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
    var response = await GetDataFromAPI.fetchData("$baseUrl/get-businesses", token);
    if (response != null) {
      final result = getBusinessesModelFromJson(response);
      if(result.businesses!.data!.isEmpty) {
        noData.value = "No data exists";
      }
      if (isRefresh) {
        businessesList.value = result.businesses!.data!;
      }else{
        businessesList.addAll(result.businesses!.data!);
      }
      if(result.businesses!.nextPageUrl != null) {
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

  final PagingController<int, Datum> pagingController = PagingController(firstPageKey: 0);

  Future<void> fetchPage(int pageKey) async {
    try {
      var token = loginDetails.read("token");
      debugPrint("This is token $token");
      isLoading.value == true;
      var response = await GetDataFromAPI.fetchData(
          "$baseUrl/get-businesses", token);
      if (response != null) {
        final result = getBusinessesModelFromJson(response);
        if (result.businesses!.data!.isEmpty) {
          noData.value = 'No request';
        }
        businessesList.value = result.businesses!.data!;
        final isLastPage = businessesList.length <= _pageSize;

        if (isLastPage) {
          pagingController.appendLastPage(businessesList);
        } else {
          final nextPageKey = pageKey + businessesList.length;
          pagingController.appendPage(businessesList, nextPageKey);
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