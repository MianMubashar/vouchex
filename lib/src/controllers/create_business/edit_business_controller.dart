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
    phoneNumber.value = Get.arguments['phone'];
    description.text = Get.arguments['description'];
    selectedBusiness.value = Get.arguments['businessTypeName'];
    selectedBusinessID = Get.arguments['business_type_id'];
    selectedProfileImagePath.value = Get.arguments['profilePhoto'];
    selectedCoverImagePath.value = Get.arguments['coverPhoto'];
    getBusinessTypeList = Get.arguments['businessTypeList'];
    businessId.value = Get.arguments['business_id'];
    super.onReady();
  }

  void registerAsBusiness() async {
    isLoading.value = true;
    var token = loginDetails.read("token");
    try{
      var request = http.MultipartRequest("POST", Uri.parse('$baseUrl/edit-business'));
      request.fields['name'] = name.text;
      request.fields['email'] = email.text;
      request.fields['phone_no'] = phoneNumber.value;
      request.fields['description'] = description.text;
      request.fields['business_type_id'] = '$selectedBusinessID';
      request.fields['business_id'] = '$selectedBusinessID';
      request.files.add(await http.MultipartFile.fromPath('profile_photo', selectedProfileImagePath.value));
      request.files.add(await http.MultipartFile.fromPath('cover_photo', selectedCoverImagePath.value));

      Map<String, String> headers = {
        "content-type": "multipart/form-data",
        'Accept': 'application/json',
        "Authorization" : "Bearer $token"
      };

      isLoading.value = false;
      request.headers.addAll(headers);
      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      print(responseString);
    } catch(e) {
      debugPrint(e.toString());
    }
  }
}