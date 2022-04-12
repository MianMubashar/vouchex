import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:vouchex/src/controllers/about_us/about_controller.dart';
import 'package:vouchex/src/data/constants.dart';
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
            FutureBuilder(
              future: _controller.aboutus(),
              builder: (ctx, snapshot) {
                if(snapshot.connectionState == ConnectionState.done) {
                  return Obx(()=>
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 15,),
                              titleText('VExchange', size: 24, fontWeight: FontWeight.w600),
                              const SizedBox(height: 5,),
                              smallText(_controller.description.value.isNotEmpty ? _controller.description.value : "No Data", size: 14),
                              const SizedBox(height: 15,),
                              titleText('Version', size: 24, fontWeight: FontWeight.w600),
                              smallText(_controller.version.value.isNotEmpty ? _controller.version.value : "No Data", size: 14),
                            ],
                          ),
                        ),
                      ),
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
