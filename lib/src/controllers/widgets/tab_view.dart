import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/data/services/services.dart';

class HomeTabs extends GetxController with GetSingleTickerProviderStateMixin{

  late TabController controller;
  var currentIndex = 0.obs;

  var userName = ''.obs;
  var profilePhotoPath = ''.obs;
  var profilePhotoUrl = ''.obs;
  var isLoading = false.obs;
  var loginDetails = GetStorage();

  final HelperFunctions _helperFunctions = HelperFunctions();

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
      userName.value = apiResponse.user.business!.name!;
      profilePhotoPath.value = apiResponse.user.business!.profilePhotoPath!;
      profilePhotoUrl.value = apiResponse.user.profilePhotoUrl!;
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
