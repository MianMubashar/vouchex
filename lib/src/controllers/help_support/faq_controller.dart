import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/data/model/help_and_support/faq_model.dart';
import 'package:vouchex/src/data/services/api/fetch_data.dart';

class FaqController extends GetxController{
  var  isLoading=false.obs;
  final loginDetails = GetStorage();
  var faqList=<FAQModel>[].obs;
  
  
  Future FAQ() async{
  isLoading.value == true;
  var token=loginDetails.read('token');
  var response=await GetDataFromAPI.fetchData('${baseUrl}/fetch-faqs', token);
  if(response != null){
    final result=await FAQs.fromJson(json.decode(response));
    faqList.value=result.faqs!;
  }
  isLoading.value == false;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    FAQ();
    super.onInit();
  }
}