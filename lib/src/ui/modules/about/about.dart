import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(
              title: "About",
              showLeadingIcon: true,
              leadingIconPressed: () {Get.back();} ,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15,),
                  titleText('VExchange', size: 24, fontWeight: FontWeight.w600),
                  const SizedBox(height: 5,),
                  smallText('In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual '
                      'form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder '
                      'before the final copy is available. In publishing and graphic design, '
                      'Lorem ipsum is a placeholder text commonly used to demonstrate', size: 14),
                  const SizedBox(height: 15,),
                  titleText('VExchange', size: 24, fontWeight: FontWeight.w600),
                  smallText('Lorem ipsum is a VExchange 2.00', size: 14),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
