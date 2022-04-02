import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/data/services/services.dart';

class SearchController extends GetxController{
  var business = false.obs;
  var voucher = false.obs;
  var isLoading = false.obs;

  final loginDetails = GetStorage();
  var selectedValue = ''.obs;
   var getBusinessTypeList = <Business>[].obs;
  var selectedBusinessType = [].obs;
  var getServicesList = <Service>[].obs;
  var selectedServicesList = [].obs;

  Future<List<Business>> getBusinessTypes() async {
    isLoading.value = true;
    var token = loginDetails.read("token");
    var response = await GetDataFromAPI.fetchData("$baseUrl/get-business-types", token);
    var result = getBusinessTypesFromJson(response!);
    getBusinessTypeList.value = result.businesses;
    var serviceResponse = await GetDataFromAPI.fetchData("$baseUrl/get-services", token);
    var serviceResult = getServicesFromJson(serviceResponse!);
    getServicesList.value = serviceResult.services;
    isLoading.value = false;
    return getBusinessTypeList;
  }

  /*Future searchBusinessOrVouchers() async {
    isLoading.value = true;
    var token = loginDetails.read("token");
    Map businessData = {
      'business_type_ids' : selectedBusinessType,
    };
    Map serviceData = {
      'service_ids' : selectedServicesList,
    };
    var body = selectedValue.value == 'Business' ? json.encode(businessData) : json.encode(serviceData);
    var response = await http.post(selectedValue.value == 'Business' ? Uri.parse('$baseUrl/search-business') : Uri.parse('$baseUrl/search-voucher'),
        headers: {
          'Content-Type': 'application/json',
          "Authorization" : "Bearer $token"
        },
        body: body
    );
    isLoading.value = false;
    if(response.statusCode == 200) {
      print(response.body);
      return response.body;
    } else {
      return print(response.body);
    }
  }*/

  @override
  void onInit() {
    getBusinessTypes();
    super.onInit();
  }

}