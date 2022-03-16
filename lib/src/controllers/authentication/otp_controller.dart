import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OtpController extends GetxController{
  var isLoading = false.obs;
  var phoneNumber = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var otp = '';

  TextEditingController fieldOne = TextEditingController();
  TextEditingController fieldTwo = TextEditingController();
  TextEditingController fieldThree = TextEditingController();
  TextEditingController fieldFour = TextEditingController();
  TextEditingController fieldFive = TextEditingController();
  TextEditingController fieldSix = TextEditingController();

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    isLoading.value = false;
    try {
      final authCredential =
      await _auth.signInWithCredential(phoneAuthCredential);
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
        verificationId: phoneNumber, smsCode: otp);
    signInWithPhoneAuthCredential(phoneAuthCredential);
  }

  @override
  void onInit() {
    phoneNumber = Get.arguments['verifyId'];
    super.onInit();
  }

}