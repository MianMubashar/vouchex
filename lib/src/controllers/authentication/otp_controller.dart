import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vouchex/src/data/constants.dart';

class OtpController extends GetxController{
  var isLoading = false.obs;
  var phoneNumber = '';
  var deviceToken = '';
  var verificationId = '';
  var countryCode = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var otp = '';

  TextEditingController fieldOne = TextEditingController();
  TextEditingController fieldTwo = TextEditingController();
  TextEditingController fieldThree = TextEditingController();
  TextEditingController fieldFour = TextEditingController();
  TextEditingController fieldFive = TextEditingController();
  TextEditingController fieldSix = TextEditingController();

  final loginDetails = GetStorage();

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    isLoading.value = false;
    try {
      final authCredential =
      await _auth.signInWithCredential(phoneAuthCredential);
      await loginRequest();
      isLoading.value = false;
      if(authCredential.user != null){
        Get.offAllNamed('/BottomBar');
      }

    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.message.toString());
    }
  }

  verifyOtp() {
    otp = fieldOne.text + fieldTwo.text + fieldThree.text + fieldFour.text + fieldFive.text + fieldSix.text;
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otp);
    signInWithPhoneAuthCredential(phoneAuthCredential);
  }

  @override
  void onInit() {
    verificationId = Get.arguments['verifyId'];
    phoneNumber = Get.arguments['phoneNumber'];
    countryCode = Get.arguments['countryCode'];
    deviceToken = loginDetails.read('device_token');
    super.onInit();
  }

  Future<http.Response> loginRequest() async {
    Map data = {
      'phone_no' : phoneNumber,
      'device_token' : deviceToken,
      'country_code' : countryCode,
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(Uri.parse('$baseUrl/login'),
        headers: {"Content-Type": "application/json"},
        body: body
    );
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }
}