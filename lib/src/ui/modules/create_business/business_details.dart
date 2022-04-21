import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/ui/modules/history/widgets/vouchers.dart';
import 'package:vouchex/src/ui/modules/home/widgets/voucher_card.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';
import '../../../data/model/models.dart';

class BusinessDetails extends StatelessWidget {
  BusinessDetails({Key? key}) : super(key: key);

  var vouchersList = <Voucher>[];
  @override
  Widget build(BuildContext context) {
    vouchersList = Get.arguments['vouchersList'] != [] ? Get.arguments['vouchersList'] : [];
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
                    child: //Image.asset("assets/images/kfc_bg.png")
                    CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: Get.arguments['coverPhoto'],
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 70),
                    child: Align(
                        alignment: Alignment.bottomLeft,
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage: NetworkImage(Get.arguments['circleImage']),
                        )
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 30, ),
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
              vouchersList.isNotEmpty ?
              Column(
                children: vouchersList.map((e) {
                  return Container(
                    decoration:  BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade100,
                          blurRadius: 20,
                          offset: const Offset(0, 2), // Shadow position
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Image.asset("assets/images/voucher_card.png",),
                            Padding(
                              padding: const EdgeInsets.only(left: 10, right: 9),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(11),
                                  topRight: Radius.circular(11),
                                ),
                                child: CachedNetworkImage(
                                  height: 80,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                  imageUrl: Get.arguments['coverPhoto'],
                                  placeholder: (context, url) => const SpinKitPulse(color: primaryColor,),
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 50, left: 30),
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.blue,
                                foregroundImage: NetworkImage(Get.arguments['circleImage']),
                              ),
                            ),
                            Positioned.fill(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20, top: 45),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: titleText(e.name!, size: 18)),
                              ),
                            ),
                            Positioned.fill(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 20, right: 20),
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: titleText(e.code != null ? '#'+e.code! : "" , size: 18),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20,),
                      ],
                    ),
                  );
                }).toList(),
              ) : Padding(
                padding: const EdgeInsets.all(8.0),
                child: smallText("No Vouchers found"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
