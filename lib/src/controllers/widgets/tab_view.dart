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
  var countryCode = ''.obs;
  var businessId= ''.obs;
  var isLoading = false.obs;
  var lat = 0.0.obs;
  var lon = 0.0.obs;
  var address = 'Tap here to get address'.obs;

  var loginDetails = GetStorage();

  //final AuthService authService = AuthService();


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
    var response  = await http.post(Uri.parse("$baseUrl/validate-token"),
      headers: {
        "Content-Type": "application/json",
        'Accept': 'application/json',
        "Authorization" : "Bearer $token"
      },
    );
    if(response.statusCode == 200) {
      var apiResponse = validateTokenModelFromJson(response.body);
      if (apiResponse.user.businessId != null) {
        userName.value = apiResponse.user.business!.name!;
        loginDetails.write('businessName', apiResponse.user.business!.name!);
        profilePhotoPath.value = apiResponse.user.business!.profilePhotoPath!;
        loginDetails.write("profile", profilePhotoPath.value);
        coverPhotoUrl.value = apiResponse.user.business!.coverPhotoPath!;
        loginDetails.write("cover", coverPhotoUrl.value);
        businessId.value = apiResponse.user.businessId.toString();
        businessEmail.value = apiResponse.user.business!.email!;
        countryCode.value = apiResponse.user.business!.countryCode!;
        lat.value = apiResponse.user.business!.lat!;
        lon.value = apiResponse.user.business!.lon!;
        address.value = apiResponse.user.business!.address!;
        return response;
      }
      else {
        return response;
      }
    }
    /*else {
      loginDetails.remove("profile");
      loginDetails.remove("cover");
      loginDetails.remove("token");
      loginDetails.remove("userId");
      loginDetails.remove("email");
      Get.offAllNamed('/');
      return response;
    }*/
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
