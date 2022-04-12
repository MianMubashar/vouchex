import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/data/model/about_us/aboutus_model.dart';
import 'package:vouchex/src/data/services/api/fetch_data.dart';

class AboutusController extends GetxController{
  
  var loginDetails = GetStorage();
  var isLoading = false.obs;
  var description = ''.obs;
  var version = ''.obs;
  var noData = ''.obs;

  Future aboutus() async{
    var token = loginDetails.read('token');
    isLoading.toggle();
    var response = await GetDataFromAPI.fetchData('$baseUrl/fetch-about-us', token);
    if(response != null){
      final result = AboutusModel.fromJson(json.decode(response));
      if(result.aboutUs != null) {
        description.value = result.aboutUs!.description;
        version.value = result.aboutUs!.app_version;
      } else {
        noData.value = "No data exists";
      }
    }
    isLoading.toggle();
  }

  @override
  void onInit() {
    aboutus();
    super.onInit();
  }
  
}