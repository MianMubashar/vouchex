import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:vouchex/src/data/constants.dart';

class ContactUsController extends GetxController {
  var isLoading = false.obs;
  final loginDetails = GetStorage();
  final TextEditingController textEditingController = TextEditingController();

  Future contactUs() async {
    isLoading.value = true;
    var token = loginDetails.read("token");
    Map data = {
      'message' : textEditingController.text,
    };
    var body = json.encode(data);
    var response = await http.post(Uri.parse('$baseUrl/contact-us'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          "Authorization" : "Bearer $token"
        },
        body: body
    );
    isLoading.value = false;
    if(response.statusCode == 200) {
      return response.body;
    } else {
      return debugPrint(response.body);
    }
  }
}