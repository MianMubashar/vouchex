import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/data/model/models.dart';

class SearchResultController extends GetxController{
  var isLoading = false.obs;
  var businessesList = <Datum>[].obs;
  var vouchersList = <AllVouchersData>[].obs;
  int currentPage = 1;
  int totalPages = 1;
  final TextEditingController search = TextEditingController();
  var searchText = ''.obs;
  final RefreshController refreshController = RefreshController(initialRefresh: true);
  var loginDetails = GetStorage();

  var serviceList = [].obs;
  var businessList = [].obs;

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
      'search' : searchText.value != "" ? searchText.value : ""
    };
    Map serviceData = {
      'service_ids' : serviceList,
      'search' : searchText.value != "" ? searchText.value : "",
      if(Get.arguments["isStatic"] != 3)
        'is_static' : Get.arguments['isStatic'],
      if(Get.arguments["isEnd"] != 3)
        'is_end': Get.arguments['isEnd'],
    };
    var body = Get.arguments['searchResult'] == 'Business' ? json.encode(businessData) : json.encode(serviceData);
    var response = await http.post(Get.arguments['searchResult'] == 'Business' ? Uri.parse('$baseUrl/search-business?page=$currentPage')
        : Uri.parse('$baseUrl/search-voucher?page=$currentPage'),
        headers: {
          'Content-Type': 'application/json',
          "Authorization" : "Bearer $token"
        },
        body: body
    );
    if (response.statusCode == 200 && response.body.isNotEmpty && Get.arguments['searchResult'] == 'Business') {
      final result = getBusinessesModelFromJson(response.body);
      if (isRefresh) {
        if(Get.arguments['searchResult'] == 'Business') {
          businessesList.value = result.businesses!.data!;
        }
      }else{
        businessesList.addAll(result.businesses!.data!);
      }
      currentPage++;
      totalPages = result.businesses!.total!;
      isLoading.value = false;
      return true;
    } else if(response.statusCode == 200 && response.body.isNotEmpty) {
      final result = getAllVouchersFromJson(response.body);
      if (isRefresh) {
        vouchersList.value = result.vouchers!.data!;
      }else{
        vouchersList.addAll(result.vouchers!.data!);
      }
      currentPage++;
      totalPages = result.vouchers!.total!;
      isLoading.value = false;
      return true;
    }
    return false;
  }

  @override
  void onInit() {
    serviceList.addAll(Get.arguments['servicesList']);
    print(Get.arguments["isStatic"]);
    searchBusinessOrVoucher();
    super.onInit();
  }

  @override
  void onReady() {

    super.onReady();
  }
}