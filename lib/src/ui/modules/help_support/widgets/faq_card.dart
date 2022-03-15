import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/data/model/help_and_support/faq_model.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';

class FAQCard extends StatelessWidget {
  const FAQCard({Key? key, required this.faqModel}) : super(key: key);

  final FAQModel faqModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: [
          Obx(() =>
              ListTile(
                onTap: (){
                  faqModel.visible.value = !faqModel.visible.value;
                },
                tileColor: const Color(0XFFF4F4F4),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                title: smallText(faqModel.question, size: 18),
                trailing: Icon(faqModel.visible.value == false ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up, color: blackText,),
              ),
          ),
          const SizedBox(height: 10,),
          Obx(() =>
              Visibility(
                visible: faqModel.visible.value,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    color: Color(0XFFF4F4F4),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: smallText(faqModel.answer),
                  ),
                ),
              )
          ),
          const SizedBox(height: 10,),
        ],
      ),
    );
  }
}
