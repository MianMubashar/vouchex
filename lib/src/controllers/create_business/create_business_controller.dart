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
  List<int> getBusinessTypeIds = [];
  List<String> businessType = ['Design Studio', 'Restaurant'];
  var selectedBusiness = ''.obs;
  var phoneNumber = ''.obs;

  TextEditingController description = TextEditingController();
  TextEditingController vName = TextEditingController();
  TextEditingController vCode = TextEditingController();
  TextEditingController vDescription = TextEditingController();
  TextEditingController marketValue = TextEditingController();
  TextEditingController terms = TextEditingController();

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


  Future registerAsBusiness() async {
    isLoading.value = true;
    var token = loginDetails.read("token");
    String dateAsString = selectedDate.value.toString();
    String formatDate = dateAsString.split('/').reversed.join('-');
    DateFormat inputFormat = DateFormat('yyyy-MM-dd');
    DateTime date = inputFormat.parse(formatDate);
    var format = "${date.year}-${date.month}-${date.day}";

    List<int> profileImageBytes = File(selectedProfileImagePath.value).readAsBytesSync();
    List<int> coverImageBytes = File(selectedCoverImagePath.value).readAsBytesSync();
    String  base64ImageProfile = base64Encode(profileImageBytes);
    String  base64ImageCover = base64Encode(coverImageBytes);
    Map data = {
      'name' : 'North 9',
      'email' : 'north9designs@gmail.com',
      'phone_no' : phoneNumber,
      'profile_photo' : base64ImageProfile,
      'cover_photo': base64ImageCover,
      'description' : description.text,
      'business_type_id' : selectedBusinessID,
      'voucher_name' : vName.text,
      'code' : vCode.text,
      'voucher_expiry' : format,
      'voucher_market_value' : double.tryParse(marketValue.text)?.toDouble(),
      'voucher_terms' : terms.text,
      'voucher_is_static' : groupValue.value,
      'voucher_service_ids' : selectedServicesListId,
    };
    var body = json.encode(data);
    var response = await http.post(Uri.parse('$baseUrl/register-as-business'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'multipart/form-data',
          "Authorization" : "Bearer $token"
        },
        body: body
    );
    isLoading.value = false;
    if(response.statusCode == 200) {
      Get.back();
      return response.body;
    } else {
      return print(response.body);
    }
  }

  Future uploadImage() async {
    isLoading.value = true;
    var token = loginDetails.read("token");
    String dateAsString = selectedDate.value.toString();
    String formatDate = dateAsString.split('/').reversed.join('-');
    DateFormat inputFormat = DateFormat('yyyy-MM-dd');
    DateTime date = inputFormat.parse(formatDate);
    var format = "${date.year}-${date.month}-${date.day}";

    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/register-as-business'));
    request.fields['name'] = 'North 9';
    request.fields['email'] = 'north9designs@gmail';
    request.fields['phone_no'] = phoneNumber.value;
    request.files.add(await http.MultipartFile.fromPath('profile_photo', selectedProfileImagePath.value));
    request.files.add(await http.MultipartFile.fromPath('cover_photo', selectedCoverImagePath.value));
    request.fields['description'] = description.text;
    request.fields['business_type_id'] = selectedBusinessID.toString();
    request.fields['voucher_name'] = vName.text;
    request.fields['code'] = vCode.text;
    request.fields['voucher_expiry'] = format;
    request.fields['voucher_market_value'] = marketValue.text;
    request.fields['voucher_terms'] = terms.text;
    request.fields['voucher_is_static'] = groupValue.value.toString();
    request.fields['voucher_is_static'] = groupValue.value.toString();
    request.fields['voucher_service_ids'] = "1";


    Map<String, String> headers = {
      "content-type": "multipart/form-data",
      'Accept': 'application/json',
      "Authorization" : "Bearer $token"
    };

    request.headers.addAll(headers);
   // http.StreamedResponse response = await request.send();
    var res = await request.send();
    print(res.statusCode);
    print(res);
    isLoading.value = false;
    return res.toString();
  }


  @override
  void onInit() {
    getBusinessTypes();
    super.onInit();
  }

}