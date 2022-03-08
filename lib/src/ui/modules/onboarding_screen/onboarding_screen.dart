
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vouchex/src/controllers/controllers.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';

class OnBoardingScreen extends StatelessWidget {
   OnBoardingScreen({Key? key}) : super(key: key);

   final OnBoardingController _onBoardingController = Get.find();

   buildDot(int index, BuildContext context) {
     return Obx(() =>
         Container(
           height: 6,
           width: _onBoardingController.currentIndex.value == index ? 33 : 16,
           margin: const EdgeInsets.only(right: 5),
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(20),
             color: _onBoardingController.currentIndex.value == index ? primaryColor : secondaryColor,
           ),
         )
     );
   }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height/20,),
            Expanded(
              child: PageView.builder(
                controller: _onBoardingController.controller,
                itemCount: contents.length,
                onPageChanged: (int index) {
                  _onBoardingController.currentIndex.value = index;
                },
                itemBuilder: (_, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(contents[index].image, width: 273,height: 273,),
                        const SizedBox(height: 50,),
                        titleText(contents[index].title, textAlign: TextAlign.center),
                        const SizedBox(height: 10,),
                        smallText(contents[index].description, textAlign: TextAlign.center)
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                contents.length,
                    (index) => buildDot(index, context),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height/18,),
            RoundedRectangleButton(
              onPress: (){Get.toNamed('/MobileNumber');},
              title: 'Get Started',
            ),
            SizedBox(height: MediaQuery.of(context).size.height/20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                smallText('Already have an account? ', textAlign: TextAlign.center),
                smallText('Login', decoration: TextDecoration.underline, clr: primaryColor),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height/9.2,),
          ],
        ),
      ),
    );
  }
}


