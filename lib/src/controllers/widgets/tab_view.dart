import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/data/services/services.dart';

import '../../data/model/authentication/validate_token_model.dart';

class HomeTabs extends GetxController with GetSingleTickerProviderStateMixin{

  late TabController controller;
  var currentIndex = 0.obs;

  var userName = ''.obs;
  var profilePhotoPath = ''.obs;
  var profilePhotoUrl = ''.obs;
  // var buisnessPhotoUrl= ''.obs;
  var buisnessEmail= ''.obs;
  var buisnessId= ''.obs;
  var isLoading = false.obs;

  var loginDetails = GetStorage();

  final List<Tab> tabs = <Tab>[
    const Tab(
        text: 'Business '
    ),
    const Tab(
      text: 'Vouchers',
    )
  ];

  @override
  void onInit() {
    controller = TabController(length: 2, vsync: this);
    controller.addListener(() {
      if(controller.indexIsChanging) {
        currentIndex.value = controller.index;
      }
    });
    validateToken();
    super.onInit();
  }

  Future validateToken() async {
    var token = loginDetails.read("token");
    debugPrint("This is token $token");
    isLoading.value == true;
    var response = await GetDataFromAPI.fetchData("$baseUrl/validate-token", token);
    if(response != null) {
      var apiResponse = validateTokenModelFromJson(response);
      if(apiResponse.user.businessId != null) {
        userName.value = apiResponse.user.business!.name!;
        profilePhotoPath.value = apiResponse.user.business!.profilePhotoPath!;
        profilePhotoUrl.value = apiResponse.user.profilePhotoUrl!;
         buisnessId.value = apiResponse.user.businessId.toString();
        buisnessEmail.value = apiResponse.user.business!.email!;

      }
      isLoading.value == false;
      return response;
    }
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
