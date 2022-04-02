import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/data/model/models.dart';

class SearchResultController extends GetxController{
  var isLoading = false.obs;
  List<Datum>? businessesList = [];
  int currentPage = 1;
  int totalPages = 1;
  final RefreshController refreshController = RefreshController(initialRefresh: true);
  var loginDetails = GetStorage();

  Future<bool> searchBusinessOrVoucher({bool isRefresh = false}) async {
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
    Map businessData = {
      'business_type_ids' : Get.arguments['businessTypeList'],
    };
    Map serviceData = {
      'service_ids' : Get.arguments['servicesList'],
    };
    var body = Get.arguments['searchResult'] == 'Business' ? json.encode(businessData) : json.encode(serviceData);
    var response = await http.post(Get.arguments['searchResult'] == 'Business' ? Uri.parse('$baseUrl/search-business') : Uri.parse('$baseUrl/search-voucher'),
        headers: {
          'Content-Type': 'application/json',
          "Authorization" : "Bearer $token"
        },
        body: body
    );
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      final result = getBusinessesModelFromJson(response.body);
      if (isRefresh) {
        businessesList = result.businesses!.data;
      }else{
        businessesList!.addAll(result.businesses!.data!);
      }
      currentPage++;
      totalPages = result.businesses!.total;
      isLoading.value = false;
      return true;
    } else {
      return false;
    }
  }

  @override
  void onInit() {
    searchBusinessOrVoucher();
    super.onInit();
  }
}