import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/data/services/services.dart';

class MyBusinessDetailsController extends GetxController {
   var isLoading = false.obs;
   var loginDetails = GetStorage();

   List<Business> getBusinessTypeList = [];

   var name = '';
   var email = '';
   var phone = '';
   var description = '';
   var businessTypeId = 0;
   var businessTypeName = '';
   var businessId = 0;
   var profilePhoto = '';
   var coverPhoto = '';

   Future validateToken() async {
      var token = loginDetails.read("token");
      debugPrint("This is token $token");
      isLoading.value == true;
      var response = await GetDataFromAPI.fetchData("$baseUrl/validate-token", token);
      isLoading.value == false;
      if(response != null) {
         var apiResponse = validateTokenModelFromJson(response);
         name = apiResponse.user.business!.name!;
         email = apiResponse.user.business!.email!;
         phone = apiResponse.user.business!.phoneNo!;
         businessId = apiResponse.user.businessId!;
         businessTypeId = apiResponse.user.business!.businessType!.id!;
         businessTypeName = apiResponse.user.business!.businessType!.name!;
         profilePhoto = apiResponse.user.business!.profilePhotoPath!;
         coverPhoto = apiResponse.user.business!.coverPhotoPath!;
         description = apiResponse.user.business!.description!;
         return response;
      }
   }

   Future<List<Business>> getBusinessTypes() async {
      var token = loginDetails.read("token");
      var response = await GetDataFromAPI.fetchData("$baseUrl/get-business-types", token);
      var result = getBusinessTypesFromJson(response!);
      getBusinessTypeList = result.businesses;
      return getBusinessTypeList;
   }

   @override
  void onInit() {
    validateToken();
    getBusinessTypes();
    super.onInit();
  }
}