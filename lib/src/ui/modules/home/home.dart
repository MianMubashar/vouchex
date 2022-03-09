import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vouchex/src/controllers/controllers.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/ui/modules/modules.dart';
import '../../widgets/global_widgets.dart';


class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);

   final HomeTabs _homeTabs = Get.put(HomeTabs());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(
              title: "Register as Business for\nmore features",
              textAlign: TextAlign.start,
              showTrailingIcon: true,
                profileImage: "assets/images/profile_img.png"
            ),
            TabBar(
              labelColor: Colors.black,
              indicatorColor: primaryColor,
              tabs: _homeTabs.tabs,
              controller: _homeTabs.controller,
            ),
            Expanded(
              child: TabBarView(
                controller: _homeTabs.controller,
                children: const [
                  BusinessScreen(),
                  VouchersScreen()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
