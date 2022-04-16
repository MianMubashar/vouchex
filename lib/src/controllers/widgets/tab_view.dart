import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/data/services/services.dart';
import '../../data/model/authentication/validate_token_model.dart';

class HomeTabs extends GetxController with GetSingleTickerProviderStateMixin{

  late TabController controller;
  var currentIndex = 0.obs;

  var userName = ''.obs;
  var profilePhotoPath = ''.obs;
  var coverPhotoUrl = ''.obs;
  var businessEmail= ''.obs;
  var businessId= ''.obs;
  var isLoading = false.obs;

  var loginDetails = GetStorage();

  final AuthService authService = AuthService();


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

  Future validateToken() async{
    var token = loginDetails.read("token");
    debugPrint("This is token $token");
    isLoading.value == true;
    var response  = await http.post(Uri.parse("$baseUrl/validate-token"),
      headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        "Authorization" : "Bearer $token"
      },
    );
    if(response.statusCode == 200) {
      isLoading.value == false;
      var apiResponse = validateTokenModelFromJson(response.body);
      if (apiResponse.user.businessId != null) {
        userName.value = apiResponse.user.business!.name!;
        profilePhotoPath.value = apiResponse.user.business!.profilePhotoPath!;
        loginDetails.write("profile", profilePhotoPath.value);
        coverPhotoUrl.value = apiResponse.user.business!.coverPhotoPath!;
        loginDetails.write("cover", profilePhotoPath.value);
        businessId.value = apiResponse.user.businessId.toString();
        businessEmail.value = apiResponse.user.business!.email!;
      }
      isLoading.value == false;
      return response;
    }
    else {
      isLoading.value == false;
      loginDetails.remove("profile");
      loginDetails.remove("cover");
      loginDetails.remove("token");
      loginDetails.remove("userId");
      authService.signOut();
      Get.offAllNamed('/');
    }
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
