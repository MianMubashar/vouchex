import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vouchex/src/controllers/controllers.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';

import 'modules.dart';

class MyVouchersScreen extends StatelessWidget {
   MyVouchersScreen({Key? key}) : super(key: key);

   final MyVouchersTabs _myVouchersTabs = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              title: "MyVouchers",
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
                tabs: _myVouchersTabs.tabs,
                controller: _myVouchersTabs.myVouchersTabController,
              ),
            ),
            const SizedBox(height: 15,),
            Expanded(
              child: TabBarView(
                controller: _myVouchersTabs.myVouchersTabController,
                children: [
                  MyVoucher(),
                  SwappedVoucher(),
                  FreeVouchers(),
                  const CreateVoucher()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
