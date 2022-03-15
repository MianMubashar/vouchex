import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';

class HelpAndSupport extends StatelessWidget {
  const HelpAndSupport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: "Help and Support",
              showLeadingIcon: true,
              leadingIconPressed: () {Get.back();} ,
            ),
            ListTile(
              onTap: (){Get.toNamed('/FAQ');},
              title: titleText('FAQ', size: 20, fontWeight: FontWeight.w400),
            ),
            ListTile(
              onTap: (){Get.toNamed('/Terms');},
              title: titleText('Terms and Conditions', size: 20, fontWeight: FontWeight.w400),
            ),
            ListTile(
              onTap: (){Get.toNamed('/ContactUs');},
              title: titleText('Contact Us', size: 20, fontWeight: FontWeight.w400),
            )
          ],
        ),
      ),
    );
  }
}
