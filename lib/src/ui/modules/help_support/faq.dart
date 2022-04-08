import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vouchex/src/controllers/help_support/faq_controller.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';

import '../../../data/model/models.dart';
import 'modules.dart';

class FAQ extends StatelessWidget {
  FAQ({Key? key}) : super(key: key);

  FaqController _controller=Get.put(FaqController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: "FAQ",
              showLeadingIcon: true,
              leadingIconPressed: () {Get.back();} ,
            ),
            const SizedBox(height: 15,),

            Expanded(
              child: Obx(()=>
                 ModalProgress(
                  call: _controller.isLoading.value,
                  child: ListView.builder(
                    itemCount: _controller.faqList.length,
                    itemBuilder: (context, index) {
                      return FAQCard(faqModel: _controller.faqList[index]);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
