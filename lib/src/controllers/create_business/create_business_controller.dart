import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/data/services/services.dart';
import 'package:http/http.dart' as http;

class CreateBusinessController extends GetxController{

  var isLoading = false.obs;
  var loginDetails = GetStorage();

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
    request.fields['voucher_name'] = vName.text;
    request.fields['code'] = vCode.text;
    request.fields['voucher_expiry'] = format ;
    request.fields['voucher_market_value'] = marketValue.text;
    request.fields['voucher_terms'] = terms.text;
    request.fields['voucher_is_static'] = '${groupValue.value}';
    for(int i = 1; i < selectedServicesListId.length; i++){
      request.fields['voucher_service_ids[$i]'] = '${selectedServicesListId[i]}';
    }

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
  }

  @override
  void onInit() {
    getBusinessTypes();
    super.onInit();
  }

}