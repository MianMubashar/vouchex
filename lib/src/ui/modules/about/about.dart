import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vouchex/src/controllers/about_us/about_controller.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';

class About extends StatelessWidget {
  About({Key? key}) : super(key: key);

  final AboutusController _controller = Get.find();

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
            Obx(()=>
               Expanded(
                 child: ModalProgress(
                  call: _controller.isLoading.value,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 15,),
                        titleText('VExchange', size: 24, fontWeight: FontWeight.w600),
                        const SizedBox(height: 5,),
                        smallText(_controller.description.value, size: 14),
                        const SizedBox(height: 15,),
                        titleText('VExchange', size: 24, fontWeight: FontWeight.w600),
                        smallText(_controller.version.value, size: 14),
                      ],
                    ),
                  ),
              ),
               ),
            )
          ],
        ),
      ),
    );
  }
}
