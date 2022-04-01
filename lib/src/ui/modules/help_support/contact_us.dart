import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vouchex/src/controllers/controllers.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';

class ContactUs extends StatelessWidget {
   ContactUs({Key? key}) : super(key: key);

   final ContactUsController _contactUsController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() =>
            ModalProgress(
              call: _contactUsController.isLoading.value,
              child: Column(
                children: [
                  CustomAppBar(
                    title: "Contact Us",
                    showLeadingIcon: true,
                    leadingIconPressed: () {Get.back();} ,
                  ),
                  const SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 16),
                    child: VoucherFields(
                      textEditingController: _contactUsController.textEditingController,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      maxLine: 4,
                      hintText: 'Tell us how we can help',
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 16),
                    child: smallText("Please write your graphic design, Lorem ipsum is a placeholder text commonly "),
                  ),
                  const SizedBox(height: 30,),
                  RoundedRectangleButton(
                    onPress: (){
                      if(_contactUsController.textEditingController.text.isNotEmpty) {
                        _contactUsController.contactUs();
                      }
                    },
                    title: 'Submit',
                  )
                ],
              ),
            ),
        )
      ),
    );
  }
}
