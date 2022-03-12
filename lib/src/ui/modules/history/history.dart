import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vouchex/src/controllers/controllers.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/ui/modules/history/modules.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';

class HistoryScreen extends StatelessWidget {
   HistoryScreen({Key? key}) : super(key: key);

   final HistoryTabs _historyTabs = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: "History",
              showLeadingIcon: true,
              leadingIconPressed: () {Get.back();} ,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: TabBar(
                isScrollable: true,
                labelColor: Colors.black,
                unselectedLabelColor: greyText,
                labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, fontFamily: 'Nunito'),
                indicatorColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorWeight: 3,
                tabs: _historyTabs.tabs,
                controller: _historyTabs.historyTabController,
              ),
            ),
            const SizedBox(height: 20,),
            Expanded(
              child: TabBarView(
                controller: _historyTabs.historyTabController,
                children: [
                  ExpiredVouchers(),
                  RedeemedVouchers()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
