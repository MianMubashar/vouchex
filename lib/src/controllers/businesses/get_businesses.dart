import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/data/services/services.dart';
import '../../data/model/models.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class GetBusinessesController extends GetxController{


  List<Datum> businessesList = [];
  int currentPage = 1;
  late int totalPages;
  final RefreshController refreshController = RefreshController(initialRefresh: true);
  var isLoading = false.obs;
  var loginDetails = GetStorage();

  Future<bool> getBusinessesData({bool isRefresh = false}) async {
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
      if (isRefresh) {
        businessesList = result.businesses.data;
      }else{
        businessesList.addAll(result.businesses.data);
      }
      currentPage++;
      totalPages = result.businesses.total;
      isLoading.value = false;
      return true;
    } else {
      return false;
    }
  }

}