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

  var myVouchersList = <MyVouchersData>[].obs;
  int currentPage = 1;
  late int totalPages;
  final RefreshController myVouchersRefreshController = RefreshController(initialRefresh: true);
  var isLoading = false.obs;
  var noData = ''.obs;
  var loginDetails = GetStorage();

  var to = 0.obs;
  var total = 0.obs;

  Future<bool> getMyVouchers({bool isRefresh = false}) async {
    if (isRefresh) {
      currentPage = 1;
    } else {
      if (to.value >= total.value) {
        myVouchersRefreshController.loadNoData();
        return false;
      }
    }
    var token = loginDetails.read("token");
    debugPrint("This is token $token");
    isLoading.value = true;
    var response = await GetDataFromAPI.fetchData("$baseUrl/my-vouchers?page=$currentPage", token);
    if (response != null) {
      final result = myVouchersFromJson(response);
      total.value = result.vouchers!.total;
      to.value = result.vouchers!.to!;
      if (isRefresh) {
        if(result.vouchers != null) {
          myVouchersList.value = result.vouchers!.data!;
          if(result.vouchers!.data!.isEmpty) {
            noData.value = 'No data exists';
          }
        }
      }else{
        if(result.vouchers != null) {
          myVouchersList.addAll(result.vouchers!.data!);
        }
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
    if(response.statusCode == 200) {
      getMyVouchers(isRefresh: true);
      print(response.body);
      return response.body;
    } else {
      return print(response.body);
    }
  }
}