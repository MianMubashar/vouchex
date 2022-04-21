import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:vouchex/src/controllers/vouchers/claim_voucher_controller.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/data/model/models.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';

import '../../../../controllers/controllers.dart';

class VoucherData extends StatelessWidget {
  VoucherData({Key? key}) : super(key: key);

  //final VoucherDataController _data = Get.put(VoucherDataController());
  final ClaimVoucherController _claimVoucherController=Get.put(ClaimVoucherController());

  final HomeTabs _homeTabs = Get.put(HomeTabs());

  var list = [];
  int? userId;
  int? voucherId;
  String? uu_id;
  @override
  Widget build(BuildContext context) {
    list = Get.arguments['services'];
    userId = Get.arguments['userId'];
    voucherId = Get.arguments['voucherId'];
    uu_id = Get.arguments['tokenCode'];
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 16, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: QrImage(
                    data: "$uu_id",
                    version: QrVersions.auto,
                    size: 150.0,
                    semanticsLabel: '$uu_id',
                  ),
              ),
              const SizedBox(
                height: 5,
              ),
              Center(
                  child:
                      cardText("Please Scan this code while using voucher")),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  titleText("Business Name", size: 20),
                  Get.arguments['isFree'] != 0
                      ? ConstrainedBox(
                          constraints: BoxConstraints.tightFor(
                              width: MediaQuery.of(context).size.width / 5),
                          child: SmallButton(
                            onPress: () {
                              // Get.toNamed('/BottomBar');
                              if(_homeTabs.businessId.value != ''){
                                _claimVoucherController.requestClaimVoucher(context,voucherId);
                              }else{
                                Get.snackbar("Please create buisness profile to enjoy more features", "", colorText: blackText,
                                    icon: const Icon(Icons.verified_outlined, color: Colors.black,),
                                    backgroundColor: Colors.white);
                              }

                              /*ImageDialog(
                                  title: 'Your Voucher has been Successfully exchange',
                                  imageUrl: 'assets/images/congrats_img.png').show(context);*/
                            },
                            title: 'Claim',
                          ),
                        )
                      : Container()
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              smallText(Get.arguments['businessName'], size: 14),
              const SizedBox(
                height: 15,
              ),
              titleText("Expiry Date", size: 20),
              const SizedBox(
                height: 4,
              ),
              smallText(Get.arguments['expiryDate'], size: 14),
              const SizedBox(
                height: 15,
              ),
              titleText("Terms & Conditions", size: 20),
              const SizedBox(
                height: 4,
              ),
              smallText(Get.arguments['terms'], size: 14),
              const SizedBox(
                height: 15,
              ),
              titleText("Services", size: 20),
              const SizedBox(
                height: 4,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: list.length,
                  itemBuilder: (context, i) {
                    return Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Container(
                            height: 25,
                            decoration: const BoxDecoration(
                                color: detailsButtonColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7))),
                            child: Center(
                              child: smallText(list[i].title!,
                                  size: 14),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
              const SizedBox(
                height: 15,
              ),
              titleText("Market Value", size: 20),
              const SizedBox(
                height: 4,
              ),
              smallText(Get.arguments['marketValue'], size: 14),
              const SizedBox(
                height: 15,
              ),
              Get.arguments['fromWhere'] == "vouchers" ?
              titleText("Token Code", size: 20) : const SizedBox(),
              const SizedBox(
                height: 4,
              ),
              Get.arguments['fromWhere'] == "vouchers" ? Row(
                children: [
                  Stack(
                    children: [
                      Image.asset(
                        "assets/images/code_img.png",
                        width: MediaQuery.of(context).size.width / 1.35,
                      ),
                      Positioned.fill(
                        child: Align(
                            alignment: Alignment.center,
                            child: smallText(Get.arguments['tokenCode'], size: 14, overflow: TextOverflow.ellipsis)),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 45,
                    height: 35,
                    decoration: const BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Center(
                      child: IconButton(
                        onPressed: () {
                          Clipboard.setData(
                              ClipboardData(text: Get.arguments['tokenCode']));
                          Get.snackbar("Text copied to clipboard", "",);
                        },
                        icon: const Icon(
                          Icons.copy,
                          size: 20,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ) : const SizedBox(),
              const SizedBox(
                height: 15,
              ),
              Get.arguments['isFree'] == 0 && Get.arguments['fromWhere'] == "vouchers"
                  ? RoundedRectangleButton(
                      onPress: () {
                        if(_homeTabs.businessId.value != '') {
                          Get.back();
                          var voucherData = {
                            'userId': userId,
                            'voucherId': voucherId,
                          };
                          Get.toNamed('/myVoucherList', arguments: voucherData);
                        }else{
                          Get.snackbar("Please create buisness profile to enjoy more features", "", colorText: blackText,
                              icon: const Icon(Icons.verified_outlined, color: Colors.black,),
                              backgroundColor: Colors.white);
                        }
                      },
                      title: "Exchange Request",
                    )
                  : const SizedBox()
            ],
          ),
        )
      ],
    );
  }
}
