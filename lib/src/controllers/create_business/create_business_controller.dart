import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:vouchex/src/controllers/controllers.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/data/services/services.dart';
import 'package:http/http.dart' as http;

class CreateBusinessController extends GetxController{

  PickLocationController _pickLocationController=Get.put(PickLocationController());
  var isLoading = false.obs;
  var loginDetails = GetStorage();

  var isVoucherFieldsVisible = false.obs;

  var selectedCoverImagePath = ''.obs;
  var selectedProfileImagePath = ''.obs;

  List<Business> getBusinessTypeList = [];
  int selectedBusinessID = 0;
  var selectedBusiness = ''.obs;
  var phoneNumber = ''.obs;

  TextEditingController description = TextEditingController();
  TextEditingController vName = TextEditingController();
  TextEditingController vCode = TextEditingController();
  TextEditingController vDescription = TextEditingController();
  TextEditingController marketValue = TextEditingController();
  TextEditingController terms = TextEditingController();

  TextEditingController businessName = TextEditingController();
  TextEditingController businessEmail = TextEditingController();

  List<Service> getServicesList = [];
  int selectedServiceId = 0;
  List<int> selectedServicesListId = [];
  var selectedDate = DateTime.now().obs;
  List<String> vType = ['Free', 'Not Free'];
  var selectedType = ''.obs;
  var selectedServicesList = [].obs;
  var selectedService = ''.obs;
  var groupValue = 3.obs;
  var countryCode = ''.obs;

  selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      builder: (context, child) {
        return Theme(data: ThemeData.dark(), child: child!);
      },
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
      helpText: 'Select Date',
      cancelText: 'Close',
      confirmText: 'Ok',
      errorFormatText: 'Enter Valid Date',
      errorInvalidText: 'Enter valid date range',
      fieldLabelText: 'Select',
      fieldHintText: 'Month/Date/Year',
    );
    if (pickedDate != null && pickedDate != selectedDate.value) {
      selectedDate.value = pickedDate;
    }
  }

  void getCoverImage(ImageSource imageSource) async {
    final pickedImage = await ImagePicker().pickImage(source: imageSource);
    selectedCoverImagePath.value = pickedImage!.path;
  }

  void getProfileImage(ImageSource imageSource) async {
    final pickedImage = await ImagePicker().pickImage(source: imageSource);
    selectedProfileImagePath.value = pickedImage!.path;
  }

  Future<List<Business>> getBusinessTypes() async {
    isLoading.value = true;
    var token = loginDetails.read("token");
    var response = await GetDataFromAPI.fetchData("$baseUrl/get-business-types", token);
    var result = getBusinessTypesFromJson(response!);
    getBusinessTypeList = result.businesses;
    var serviceResponse = await GetDataFromAPI.fetchData("$baseUrl/get-services", token);
    var serviceResult = getServicesFromJson(serviceResponse!);
    getServicesList = serviceResult.services;
    isLoading.value = false;
    return getBusinessTypeList;
  }


  void registerAsBusiness() async {
    try{

      isLoading.value = true;
      String dateAsString = selectedDate.value.toString();
      String formatDate = dateAsString.split('/').reversed.join('-');
      DateFormat inputFormat = DateFormat('yyyy-MM-dd');
      DateTime date = inputFormat.parse(formatDate);
      var format = "${date.year}-${date.month}-${date.day}";
      var token = loginDetails.read("token");
      var request = http.MultipartRequest("POST", Uri.parse('$baseUrl/register-as-business'));
      request.fields['name'] = businessName.text;
      request.fields['email'] = businessEmail.text;
      request.fields['phone_no'] = phoneNumber.value;
      request.files.add(await http.MultipartFile.fromPath('profile_photo', selectedProfileImagePath.value));
      request.files.add(await http.MultipartFile.fromPath('cover_photo', selectedCoverImagePath.value));
      request.fields['description'] = description.text;
      request.fields['business_type_id'] = '$selectedBusinessID';
      request.fields['country_code'] = countryCode.value;
      request.fields['lat'] = _pickLocationController.lat.value.toString();
      request.fields['lng'] = _pickLocationController.long.value.toString();


      if(isVoucherFieldsVisible.value == true) {
        if((vName.text.isNotEmpty) && (vCode.text.isNotEmpty) && (selectedDate.value != DateTime.now()) && (marketValue.text.isNotEmpty) &&
            (terms.text.isNotEmpty) && (groupValue.value != 3) && (selectedServicesListId.isNotEmpty)) {
          request.fields['voucher_name'] = vName.text;
          request.fields['code'] = vCode.text;
          request.fields['voucher_expiry'] = format ;
          request.fields['voucher_market_value'] = marketValue.text;
          request.fields['voucher_terms'] = terms.text;
          request.fields['voucher_is_static'] = '${groupValue.value}';
          for(int i = 0; i < selectedServicesListId.length; i++){
            request.fields['voucher_service_ids[$i]'] = '${selectedServicesListId[i]}';
          }
        } else {
          isLoading.value = false;
        }
      }

      Map<String, String> headers = {
        "content-type": "multipart/form-data",
        'Accept': 'application/json',
        "Authorization" : "Bearer $token"
      };
      request.headers.addAll(headers);
      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      if (kDebugMode) {
        print(responseString);
      }
      var jsonString = json.decode(responseString) as Map<String,dynamic>;
      var resStatus = jsonString['status'];
      if(resStatus == true) {
        isLoading.value = false;
        Get.offAndToNamed('/BottomBar');
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
      }
    }catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", "Something went wrong");
      debugPrint(e.toString());
    }
  }

  @override
  void onInit() {
    getBusinessTypes();
    super.onInit();
  }

}