import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/data/services/services.dart';

class TermsConditionsController extends GetxController {

  var loginDetails = GetStorage();

  var isLoading = false.obs;
  var privacyPolicy = ''.obs;
  var termsCondition = ''.obs;

  Future getTermCondition() async {
    var token = loginDetails.read("token");
    debugPrint("This is token $token");
    isLoading.value == true;
    var response = await GetDataFromAPI.fetchData("$baseUrl/fetch-term-conditions", token);
    if(response != null) {
      final result = termsConditionModelFromJson(response);
      privacyPolicy.value = result.termConditions.privacyPolicy;
      termsCondition.value = result.termConditions.termsConditions;
    }
    isLoading.value == false;
  }

  @override
  void onInit() {
    getTermCondition();
    super.onInit();
  }
}