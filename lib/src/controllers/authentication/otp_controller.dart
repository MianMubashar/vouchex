import 'dart:convert';
import '../../data/model/models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/data/services/helper_functions.dart';

class OtpController extends GetxController{
  var isLoading = false.obs;
  var phoneNumber = '';
  var deviceToken = '';
  var verificationId = '';
  var countryCode = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var otp = '';

  Map storageList = {};

  TextEditingController fieldOne = TextEditingController();
  TextEditingController fieldTwo = TextEditingController();
  TextEditingController fieldThree = TextEditingController();
  TextEditingController fieldFour = TextEditingController();
  TextEditingController fieldFive = TextEditingController();
  TextEditingController fieldSix = TextEditingController();

  final loginDetails = GetStorage();
  final HelperFunctions _helperFunctions = HelperFunctions();

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    isLoading.value = true;
    try {
      final authCredential =
      await _auth.signInWithCredential(phoneAuthCredential);
      await loginRequest();
      isLoading.value = false;
      if(authCredential.user != null){
        Get.offAllNamed('/BottomBar',);
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

  Future<List?> loginRequest() async {
    Map data = {
      'phone_no' : phoneNumber,
      'device_token' : deviceToken,
      'country_code' : countryCode,
    };

    var body = json.encode(data);

    var response = await http.post(Uri.parse('$baseUrl/login'),
        headers: {"Content-Type": "application/json"},
        body: body
    );
    if(response.statusCode == 200) {
      var json = response.body;
      print(json);
      var loginResponse = loginFromJson(json);
      if(loginResponse.status == true){
        _helperFunctions.saveUserToken(loginResponse.token);
        _helperFunctions.saveUserId(loginResponse.user!.id!);

        storageList['name'] = loginResponse.user!.business!.name!;
        storageList['email'] = loginResponse.user!.business!.email;
        storageList['phone_no'] = loginResponse.user!.business!.phoneNo;
        storageList['description'] = loginResponse.user!.business!.description;
        storageList['business_type_id'] = loginResponse.user!.business!.businessTypeId;
        storageList['business_type_name'] = loginResponse.user!.business!.businessType!.name;
        storageList['business_id'] = loginResponse.user!.businessId;
        storageList['profile_photo'] = loginResponse.user!.business!.profilePhotoPath;
        storageList['cover_photo'] = loginResponse.user!.business!.coverPhotoPath;

        loginDetails.write('businessData', storageList);

        return [loginResponse.status, loginResponse.token, loginResponse.message, loginResponse.user, ""];
      } else if(loginResponse.status == false){
        print('hereeeee');
        return ["", "Unknown Error"];
      }
    } else {
      var json = response.body;
      var errorResp = loginErrorResponseFromJson(json);
      if (errorResp.status == false) {
        Get.snackbar("Error", "");
        return ["", "Unknown Error"];
      } else {
        return ["", errorResp.error];
      }
    }
    return null;
  }
}