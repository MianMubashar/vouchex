import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';

class PhoneController extends GetxController{
   var isLoading = false.obs;
   var phoneNumber = ''.obs;
   var verifyId = ''.obs;
   var countryCode = ''.obs;
   final FirebaseAuth _auth = FirebaseAuth.instance;

   final TextEditingController emailController  = TextEditingController();
   final TextEditingController passwordController  = TextEditingController();

   /*Future login() async{
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
                   "phoneNumber": phoneNumber.value.toString(),
                   "countryCode": countryCode.value.toString(),
                };
                FirebaseMessaging.instance.subscribeToTopic('all');
                Get.toNamed('/OtpScreen', arguments: loginData);
             },
             codeAutoRetrievalTimeout: (verificationId) async {}
         );

      } catch(e) {
         debugPrint(e.toString());
      }
   }*/

   Future register() async {
      try{
         Map data = {
            'email' : emailController.text,
            'password' : passwordController.text,
         };

         var body = json.encode(data);

         isLoading.value = true;
         var response = await http.post(Uri.parse('$baseUrl/register'),
             headers: {"Content-Type": "application/json"},
             body: body
         );
         if(response.statusCode == 200) {
            var apiResponse = response.body;
            var jsonString = json.decode(apiResponse) as Map<String,dynamic>;
            var resStatus = jsonString['status'];
            if(resStatus == true) {
               isLoading.value = false;
               Get.toNamed('/Login');
               ImageDialog(
                   imageUrl: 'assets/images/congrats_img.png',
                   title: 'Congratulations\n${jsonString['message']}'
               ).show(Get.context);
            } else {
               isLoading.value = false;
               if(jsonString.containsKey("error")){
                  var errors = jsonString["error"] as Map<String,dynamic>;
                  var errorMessage = "";
                  errors.forEach((key, value) {
                     var data = value[0];
                     errorMessage += data;
                     errorMessage += "\n";
                  });
                  Get.snackbar("Error", errorMessage);
               }else if(jsonString.containsKey("message")){
                  Get.snackbar("Error", jsonString['message']);
               }else{
                  Get.snackbar("Error", "Something went wrong");
               }
               if (kDebugMode) {
                  print(jsonString);
               }
            }
         } else {
            if (kDebugMode) {
              print(response.statusCode);
              var apiResponse = response.body;
              var jsonString = json.decode(apiResponse) as Map<String,dynamic>;
              isLoading.value = false;
              if(jsonString.containsKey("error")){
                 var errors = jsonString["error"] as Map<String,dynamic>;
                 var errorMessage = "";
                 errors.forEach((key, value) {
                    var data = value[0];
                    errorMessage += data;
                    errorMessage += "\n";
                 });
                 Get.snackbar("Error", errorMessage);
              }else if(jsonString.containsKey("message")){
                 Get.snackbar("Error", jsonString['message']);
              }else{
                 Get.snackbar("Error", "Something went wrong");
              }
              if (kDebugMode) {
                 print(jsonString);
              }
            }
         }
      } catch (e) {
         if (kDebugMode) {
           print(e);
         }
      }

   }
}