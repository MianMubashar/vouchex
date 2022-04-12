import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:vouchex/src/controllers/controllers.dart';
import 'package:vouchex/src/data/constants.dart';
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
            FutureBuilder(
              future: _controller.getTermCondition(),
              builder: (ctx, snapshot) {
                if(snapshot.connectionState == ConnectionState.done) {
                  return Obx(() =>
                      Padding(
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
                      )
                  );
                } else {
                  return const Center(
                    child: SpinKitThreeBounce(color: primaryColor, size: 30,),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
