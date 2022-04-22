import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:http/http.dart' as http;

class EditBusinessController extends GetxController {
  var isLoading  = false.obs;

  var selectedCoverImagePath = ''.obs;
  var selectedProfileImagePath = ''.obs;
  int selectedBusinessID = 0;
  var selectedBusiness = ''.obs;
  var phoneNumber = ''.obs;
  var businessId = 0.obs;
  var loginDetails = GetStorage();
  var countryCode = ''.obs;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var address = 'Tap to get location'.obs;


  var profileFromServer = ''.obs;
  var coverFromServer = ''.obs;
  List<Business> getBusinessTypeList = [];

  TextEditingController description = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();


  void getCoverImage(ImageSource imageSource) async {
    final pickedImage = await ImagePicker().pickImage(source: imageSource);
    selectedCoverImagePath.value = pickedImage!.path;
  }

  void getProfileImage(ImageSource imageSource) async {
    final pickedImage = await ImagePicker().pickImage(source: imageSource);
    selectedProfileImagePath.value = pickedImage!.path;
  }

  @override
  void onReady() {
    name.text = Get.arguments['name'];
    email.text = Get.arguments['email'];
    description.text = Get.arguments['description'];
    selectedBusiness.value = Get.arguments['businessTypeName'];
    selectedBusinessID = Get.arguments['business_type_id'];
    profileFromServer.value = Get.arguments['profilePhoto'];
    coverFromServer.value = Get.arguments['coverPhoto'];
    getBusinessTypeList = Get.arguments['businessTypeList'];
    businessId.value = Get.arguments['business_id'];
    address.value= Get.arguments['address'];

    super.onReady();
  }

  void editAsBusiness() async {
    isLoading.value = true;
    var token = loginDetails.read("token");
    try{
      var request = http.MultipartRequest("POST", Uri.parse('$baseUrl/edit-business'));
      request.fields['name'] = name.text;
      request.fields['email'] = email.text;
      request.fields['phone_no'] = phoneNumber.value;
      request.fields['description'] = description.text;
      request.fields['business_type_id'] = '$selectedBusinessID';
      request.fields['business_id'] = '${businessId.value}';

      if((selectedProfileImagePath.value != '') && (selectedCoverImagePath.value != '')) {
        request.files.add(await http.MultipartFile.fromPath('profile_photo', selectedProfileImagePath.value));
        request.files.add(await http.MultipartFile.fromPath('cover_photo', selectedCoverImagePath.value));
      }
      request.fields['country_code'] = countryCode.value;
      request.fields['lat'] = latitude.value.toString();
      request.fields['lng'] = longitude.value.toString();
      request.fields['address'] = address.value;
      Map<String, String> headers = {
        "content-type": "multipart/form-data",
        'Accept': 'application/json',
        "Authorization" : "Bearer $token"
      };
      request.headers.addAll(headers);
      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      print(responseString);
      var jsonString = json.decode(responseString);
      var resStatus = jsonString['status'];
      if(resStatus == true) {
        isLoading.value = false;
        Get.back();
        //Get.arguments['name']=name.text;

        //Get.offAndToNamed('/Profile');
      } else {
        isLoading.value = false;
        if(jsonString.containsKey("error")){
          var errors = jsonString["error"] as Map<String,dynamic>;
          var errorMessage = "";
          errors.forEach((key, value) {
            var data = value[0];
            errorMessage += data;
            errorMessage += "\n";
          });
          Get.snackbar("Error", errorMessage);
        }else if(jsonString.containsKey("message")){
          Get.snackbar("Error", jsonString['message']);
        }else{
          Get.snackbar("Error", "Something went wrong");
        }
        if (kDebugMode) {
          print(jsonString);
        }
        if (kDebugMode) {
          print(jsonString);
        }
      }
    } catch(e) {
      isLoading.value = false;
      Get.snackbar("Error", "Something went wrong");
      debugPrint(e.toString());
    }
  }

  @override
  void onInit() {
    phoneNumber.value = Get.arguments['phone'];
    countryCode.value = Get.arguments['countryCode'];
    super.onInit();
  }
}