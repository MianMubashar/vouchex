
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
    Map data = {
      'name' : vName.text,
      'code' : vCode.text,
      'service_ids' : selectedServicesListId,
      'expiry' : format,
      'market_value' : double.tryParse(marketValue.text)?.toDouble(),
      'terms' : terms.text,
      'is_static' : groupValue.value
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
  }

  @override
  void onInit() {
    getServices();
    super.onInit();
  }
}