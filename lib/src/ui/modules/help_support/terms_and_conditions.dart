import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vouchex/src/controllers/controllers.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';

class TermsAndCondition extends StatelessWidget {
   TermsAndCondition({Key? key}) : super(key: key);

   final TermsConditionsController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(
              title: "Terms and Conditions",
              showLeadingIcon: true,
              leadingIconPressed: () {Get.back();} ,
            ),
            const SizedBox(height: 15,),
            Obx(() =>
                ModalProgress(
                  call: _controller.isLoading.value,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        titleText("Terms & Conditions", size: 18),
                        const SizedBox(height: 15,),
                        smallText(_controller.termsCondition.value, size: 14),
                        const SizedBox(height: 15,),
                        titleText("Privacy Policy", size: 18),
                        smallText(_controller.privacyPolicy.value, size: 14),
                      ],
                    ),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
