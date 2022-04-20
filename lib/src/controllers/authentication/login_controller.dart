import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/data/services/services.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  final loginDetails = GetStorage();

  final TextEditingController emailController  = TextEditingController();
  final TextEditingController passwordController  = TextEditingController();

  final HelperFunctions _helperFunctions = HelperFunctions();

  Future<List?> loginRequest() async {
    isLoading.value = true;
    var deviceToken = loginDetails.read('device_token');
    Map data = {
      'email' : emailController.text,
      'device_token' : deviceToken,
      'password' : passwordController.text,
    };
    var body = json.encode(data);
    var response = await http.post(Uri.parse('$baseUrl/login'),
        headers: {"Content-Type": "application/json"},
        body: body
    );
    if(response.statusCode == 200) {
      var apiRes = response.body;
      print(apiRes);
      var loginResponse = loginFromJson(apiRes);
      if(loginResponse.status == true){
        isLoading.value = false;
        _helperFunctions.saveUserToken(loginResponse.token!);
        _helperFunctions.saveUserId(loginResponse.user!.id!);
        _helperFunctions.saveUserEmail(loginResponse.user!.email!);
        Get.offAllNamed('/BottomBar');
        return [loginResponse.status, loginResponse.token, loginResponse.message, loginResponse.user, ""];
      } else if(loginResponse.status == false){
        isLoading.value = false;
        Get.snackbar("Error", loginResponse.message!);
        return ["", "Unknown Error"];
      }
    } else {
      isLoading.value = false;
      print("Error");
    }
    return null;
  }
}