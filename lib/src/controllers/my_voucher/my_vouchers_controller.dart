import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/data/services/services.dart';

class MyVoucherController extends GetxController{

  List<MyVouchersData>? myVouchersList = [];
  int currentPage = 1;
  late int totalPages;
  final RefreshController refreshController = RefreshController(initialRefresh: true);
  var isLoading = false.obs;
  var loginDetails = GetStorage();

  Future<bool> getMyVouchers({bool isRefresh = false}) async {
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
    var response = await GetDataFromAPI.fetchData("$baseUrl/my-vouchers", token);
    if (response != null) {
      final result = myVouchersFromJson(response);
      if (isRefresh) {
        if(result.vouchers != null) {
          myVouchersList = result.vouchers!.data;
        }
      }else{
        myVouchersList!.addAll(result.vouchers!.data!);
      }
      currentPage++;
      totalPages = result.vouchers!.total;
      isLoading.value = false;
      return true;
    } else {
      return false;
    }
  }

  Future deleteVoucher(int voucherId) async {
    isLoading.value = false;
    Map data = {
      'voucher_id' : voucherId
    };
    var token = loginDetails.read("token");
    var body = json.encode(data);
    var response = await http.post(Uri.parse('$baseUrl/delete-voucher'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          "Authorization" : "Bearer $token"
        },
        body: body
    );
    isLoading.value = false;
    if(response.statusCode == 200) {
      Get.back();
      print(response.body);
      return response.body;
    } else {
      return print(response.body);
    }
  }
}