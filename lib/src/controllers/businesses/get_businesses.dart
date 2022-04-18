import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/data/services/services.dart';
import '../../data/model/models.dart';

class GetBusinessesController extends GetxController{


  var businessesList = <Datum>[].obs;
  int currentPage = 1;
  var isLoading = false.obs;
  var loginDetails = GetStorage();

  var perPage = 0.obs;
  var listSize = 0.obs;


  final PagingController<int, Datum> pagingController = PagingController(firstPageKey: 0);

  Future<void> fetchPage({bool isRefresh = false}) async {
    try {
      var token = loginDetails.read("token");
      debugPrint("This is token $token");
      isLoading.value == true;

      if(isRefresh) {
        pagingController.itemList!.length = 0;
        businessesList.length = 0;
        currentPage = 1;
        var response = await GetDataFromAPI.fetchData("$baseUrl/get-businesses?page=$currentPage", token);
        if (response != null) {
          final result = getBusinessesModelFromJson(response);

          businessesList.value = result.businesses!.data!;
          perPage.value = result.businesses!.perPage!;
          listSize.value = result.businesses!.total!;
          final isLastPage = listSize.value == result.businesses!.to;
          if (isLastPage) {
            pagingController.appendLastPage(businessesList);
          } else {
            currentPage++;
            var nextPageKey = currentPage;
            pagingController.appendPage(businessesList, nextPageKey);
          }
        }
      } else {
        var response = await GetDataFromAPI.fetchData("$baseUrl/get-businesses?page=$currentPage", token);
        if (response != null) {
          final result = getBusinessesModelFromJson(response);

          businessesList.value = result.businesses!.data!;
          perPage.value = result.businesses!.perPage!;
          listSize.value = result.businesses!.total!;
          final isLastPage = listSize.value == result.businesses!.to;
          if (isLastPage) {
            pagingController.appendLastPage(businessesList);
          } else {
            currentPage++;
            var nextPageKey = currentPage;
            pagingController.appendPage(businessesList, nextPageKey);
          }
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
    pagingController.addPageRequestListener((currentPage) {
      fetchPage();
    });
    super.onInit();
  }
}