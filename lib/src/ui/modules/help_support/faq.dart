import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';

import '../../../data/model/models.dart';
import 'modules.dart';

class FAQ extends StatelessWidget {
  const FAQ({Key? key}) : super(key: key);

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
              child: ListView.builder(
                itemCount: faqList.length,
                itemBuilder: (context, index) {
                  return FAQCard(faqModel: faqList[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
