import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/ui/modules/history/widgets/vouchers.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';
import '../../../data/model/models.dart';

class BusinessDetails extends StatelessWidget {
  const BusinessDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                title: Get.arguments['title'],
                showLeadingIcon: true,
                leadingIconPressed: () {Get.back();} ,
              ),
              Stack(
                children: [
                  Container(
                    height: 107,
                    width: MediaQuery.of(context).size.width,
                    color: const Color(0XFFF7F7F7),
                    child: Image.asset("assets/images/kfc_bg.png")
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, top: 50),
                    child: Align(
                        alignment: Alignment.bottomLeft,
                        child: SizedBox(
                          width: 120,
                          height: 120,
                          child: Image.asset(Get.arguments['circleImage']),
                        )
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: smallText(Get.arguments['title'], size: 20, clr: Colors.black),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: smallText(Get.arguments['email']),
              ),
              const SizedBox(height: 15,),
              Container(
                color: profileBg,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          smallText("Business Type", size: 18, clr: Colors.black),
                          smallText("Contact Number", size: 18, clr: Colors.black),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          smallText(Get.arguments['businessType'], size: 16),
                          smallText(Get.arguments['number'], size: 16),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      smallText("Description", size: 18, clr: Colors.black),
                      smallText(Get.arguments['description'], size: 16),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: titleText("Voucher", size: 20),
              ),
              const SizedBox(height: 10,),
              ListView.builder(
                shrinkWrap: true,
                itemCount: swappedVoucherList.length,
                itemBuilder: (context, index) {
                  return VoucherHistoryCard(model: swappedVoucherList[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
