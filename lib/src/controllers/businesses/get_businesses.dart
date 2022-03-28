import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:vouchex/src/data/constants.dart';

import '../../data/model/models.dart';

class GetBusinessesController extends GetxController{

  var businessesList = <GetBusinessesModel>[].obs;

  Future<GetBusinessesModel?> getBusinessesData() async {
    try{
      var response = await http.post(Uri.parse('$baseUrl/get-businesses'),
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
          "Authorization" : "Bearer 6|k1heeJMZbT2EE0Vu7REOXNx4kISeI0uaxEVLPecC"
        },
      );

      var businessesModel = getBusinessesModelFromJson(response.body);
      businessesList.add(businessesModel);
      return businessesModel;
    } catch (e) {
      if(e is IOException) {
        debugPrint("Check Internet connection");
      } else {
        debugPrint(e.toString());
      }
    }
    return null;
  }

  @override
  void onInit() {
    getBusinessesData();
    super.onInit();
  }
}