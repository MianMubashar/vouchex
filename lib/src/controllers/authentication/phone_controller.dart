import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PhoneController extends GetxController{
   var isLoading = false.obs;
   var phoneNumber = ''.obs;
   var verifyId = ''.obs;
   final FirebaseAuth _auth = FirebaseAuth.instance;

   Future login() async{
      isLoading.toggle();
      try{
         await _auth.verifyPhoneNumber(
             phoneNumber: phoneNumber.value,
             verificationCompleted: (phoneAuthCredentials){
                isLoading.value = false;
             },
             verificationFailed: (phoneAuthCredentials){
                isLoading.value = false;
                Get.snackbar("Error", phoneAuthCredentials.code);
             },
             codeSent: (verificationId, resendingToken){
                isLoading.value = false;
                var  loginData = {
                   "verifyId" : verificationId,
                };
                FirebaseMessaging.instance.subscribeToTopic('all');
                Get.toNamed('/OtpScreen', arguments: loginData);
             },
             codeAutoRetrievalTimeout: (verificationId) async {}
         );

      } catch(e) {
         debugPrint(e.toString());
      }
   }
}