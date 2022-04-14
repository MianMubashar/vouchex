
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/data/services/api/fetch_data.dart';

class CreateVoucherController extends GetxController {

  var isLoading  = false.obs;
  TextEditingController vName = TextEditingController();
  TextEditingController vCode = TextEditingController();
  TextEditingController marketValue = TextEditingController();
  TextEditingController terms = TextEditingController();
  final loginDetails = GetStorage();

  var selectedDate = DateTime.now().obs;
  List<Service> getServicesList = [];
  int selectedServiceId = 0;
  List<int> selectedServicesListId = [];
  var selectedType = ''.obs;
  var selectedServicesList = [].obs;
  var selectedService = ''.obs;
  var groupValue = 3.obs;
  var selectedGroupValue = false.obs;
  var vType = 3.obs;
  var selectedVType = false.obs;

  var voucherId = 0.obs;

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

  Future<List<Service>> getServices() async {
    isLoading.value = true;
    var token = loginDetails.read("token");
    var response = await GetDataFromAPI.fetchData("$baseUrl/get-services", token);
    var result = getServicesFromJson(response!);
    getServicesList = result.services;
    isLoading.value = false;
    return getServicesList;
  }


  Future createVoucher() async {

    isLoading.value = true;
    var token = loginDetails.read("token");
    String dateAsString = selectedDate.value.toString();
    String formatDate = dateAsString.split('/').reversed.join('-');
    DateFormat inputFormat = DateFormat('yyyy-MM-dd');
    DateTime date = inputFormat.parse(formatDate);
    var format = "${date.year}-${date.month}-${date.day}";

    if((vName.text.isNotEmpty) && (vCode.text.isNotEmpty) && (selectedServicesListId.isNotEmpty) &&
        (marketValue.text.isNotEmpty) && (terms.text.isNotEmpty) && (groupValue.value != 3)) {
      Map data = {
        'name' : vName.text,
        'code' : vCode.text,
        'service_ids' : selectedServicesListId,
        'expiry' : format,
        'market_value' : double.tryParse(marketValue.text)?.toDouble(),
        'terms' : terms.text,
        'is_static' : selectedGroupValue.value,
        'is_free' : selectedVType.value
      };
      var body = json.encode(data);
      var response = await http.post(Uri.parse('$baseUrl/create-voucher'),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
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
    } else {
      isLoading.value = false;
      Get.snackbar("Empty fields", "Please fill all fields");
    }

  }

  Future updateVoucher() async{
    isLoading.value = true;
    var token = loginDetails.read("token");
    String dateAsString = selectedDate.value.toString();
    String formatDate = dateAsString.split('/').reversed.join('-');
    DateFormat inputFormat = DateFormat('yyyy-MM-dd');
    DateTime date = inputFormat.parse(formatDate);
    var format = "${date.year}-${date.month}-${date.day}";
    Map data = {
      'voucher_id' : voucherId.value,
      'name' : vName.text,
      'service_ids' : selectedServicesListId,
      'expiry' : format,
      'market_value' : double.tryParse(marketValue.text)?.toDouble(),
      'terms' : terms.text,
      'is_static' : selectedGroupValue.value,
    //  'is_free' : selectedVType.value
    };
    var body = json.encode(data);
    var response = await http.post(Uri.parse('$baseUrl/edit-voucher'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
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

  @override
  void onInit() {
    getServices();
    voucherId.value = Get.arguments["v_id"];
    super.onInit();
  }

  @override
  void onReady() {
    vName.text = Get.arguments["name"] ?? "";
    vCode.text = Get.arguments["code"] ?? "";
    selectedServicesListId = Get.arguments["selectedServiceId"] ?? [];
    marketValue.text = Get.arguments["market_value"] ?? "";
    terms.text = Get.arguments["terms"] ?? "";
    groupValue.value = int.parse(Get.arguments["is_static"]);
    selectedDate.value = Get.arguments["expiry"];
    selectedServicesList.value = Get.arguments["selectedServiceTitle"] ?? [];
    super.onReady();
  }
}