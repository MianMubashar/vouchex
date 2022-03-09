import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vouchex/src/controllers/authentication/otp_controller.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';

class OtpScreen extends StatelessWidget {
   OtpScreen({Key? key}) : super(key: key);

   final OtpController _otpController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/images/otp_img.png", width: 267,height: 197,),
          const SizedBox(height: 30,),
          smallText("Enter OTP", size: 18, clr: blackText),
          const SizedBox(height: 5,),
          smallText("We have sent you access code via SMS\nfor Mobile Verification", size: 15, textAlign: TextAlign.center),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40, top: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OtpInput(controller: _otpController.fieldOne, autoFocus: false,
                  onChanged: (value) {
                  if (value!.length == 1) {
                    FocusScope.of(context).nextFocus();
                  }
                }),
                OtpInput(controller: _otpController.fieldTwo, autoFocus: false,
                    onChanged: (value) {
                      if (value!.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                    }
                ),
                OtpInput(controller: _otpController.fieldThree, autoFocus: false,
                    onChanged: (value) {
                      if (value!.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                    }
                ),
                OtpInput(controller: _otpController.fieldFour, autoFocus: false,
                    onChanged: (value) {
                      if (value!.length == 1) {
                        FocusScope.of(context).nextFocus();
                      }
                    }
                ),
                OtpInput(controller: _otpController.fieldFive, autoFocus: false,
                    onChanged: (value) {
                      if (value!.length == 1) {
                        FocusScope.of(context).unfocus();
                      }
                    }
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height/15),
          RoundedRectangleButton(
            onPress: (){Get.toNamed('/BottomBar');},
            title: 'Verify',
          ),
          SizedBox(height: MediaQuery.of(context).size.height/25),
          smallText("Didn’t Receive the OTP?", size: 20),
          InkWell(
            onTap: (){},
              child: smallText("Resend Code", clr: blackText, size: 20),
          ),
        ],
      ),
    );
  }
}
