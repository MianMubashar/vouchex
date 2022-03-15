import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';

class TermsAndCondition extends StatelessWidget {
  const TermsAndCondition({Key? key}) : super(key: key);

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
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titleText("Terms & Conditions", size: 18),
                  const SizedBox(height: 15,),
                  smallText("In publishing and graphic design, Lorem ipsum is a placeholder text"
                      " commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content.", size: 14),
                  const SizedBox(height: 15,),
                  smallText("In publishing and graphic design, Lorem ipsum is a placeholder text"
                      " commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content.", size: 14),
                  const SizedBox(height: 15,),
                  titleText("Privacy Policy", size: 18),
                  smallText("In publishing and graphic design, Lorem ipsum is a placeholder text"
                      " commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content.", size: 14),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
