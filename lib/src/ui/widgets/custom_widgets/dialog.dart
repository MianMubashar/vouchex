import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/data/model/voucher/my_swapped_vouchers_model.dart';
import 'package:vouchex/src/ui/widgets/custom_widgets/text_widgets.dart';

import '../../../data/model/models.dart';

class AppDialog {
  final SwappedVouchersList? model;
  final String? oKText, cancelText;
  final void Function()? oKPressed, cancelPressed;
  final bool? showCancelButton, showOkButton;
  final int exchangeRequestId;
  final String requesteeVoucherName;
  final String requesteeVoucherCode;
  final String requesteeProfileImage;
  final String requesteeCoverImage;
  final String requesterVoucherName;
  final String requesterVoucherCode;
  final String requesterProfileImage;
  final String requesterCoverImage;
  final String requesterTerms;
  String isRequesterOrRequestee ;

  AppDialog({
    this.model,
    this.oKText = 'OK',
    this.cancelText = 'Cancel',
    this.oKPressed,
    this.cancelPressed,
    this.showCancelButton = true,
    this.showOkButton = true,
    required this.exchangeRequestId,
    required this.requesteeVoucherName,
    required this.requesteeVoucherCode,
    required this.requesteeProfileImage,
    required this.requesteeCoverImage,
    required this.requesterVoucherName,
    required this.requesterVoucherCode,
    required this.requesterProfileImage,
    required this.requesterCoverImage,
    required this.requesterTerms,
    this.isRequesterOrRequestee = 'requester'

  });

  show(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        insetPadding: const EdgeInsets.all(10),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12))
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 70,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.info_outline_rounded, color: Colors.black,),
                        const SizedBox(width: 5,),
                        titleText("Details", size: 18),
                      ],
                    ),
                    Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: (){Get.back();},
                          icon: Image.asset("assets/images/cancel_img.png"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: const Color(0XFFF0F0F0),
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 26, right: 26, top: 18, bottom: 18),
                  child: smallText(requesterTerms),
                ),
            ),
            const SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  titleText("Adidas", size: 16),
                  titleText("You", size: 16),
                ],
              ),
            ),
            const SizedBox(height: 5,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15 , vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      if(isRequesterOrRequestee == 'requestee'){
                        Get.back();
                        var voucherData = {
                          "qrImage" : "assets/images/qr_code.png",
                          "businessName" : model?.requestee?.business == null ? '': model?.requestee?.business?.name ,
                          "expiryDate" : DateFormat("dd/MM/yyyy").format(model!.requesteeVoucher!.expiry!),
                          "terms" : model!.requesteeVoucher!.termsConditions,
                          "services" : model?.requesteeVoucher?.services ,
                          "marketValue" : model!.requesteeVoucher!.marketValue ?? '',
                          "tokenCode" : model!.requesteeVoucher!.uuId ?? '',
                          "isFree" : model!.requesteeVoucher!.isFree,
                          'userId':model!.requesteeVoucher!.userId,
                          'voucherId': model!.requesteeVoucher!.id,
                          'fromWhere' : 'my_swapped_vouchers'
                        };
                        Get.toNamed('/VoucherDetails', arguments: voucherData);
                      }
                    },
                    child: Stack(
                      children: [
                        Image.asset("assets/images/voucher_card.png", width: 140),
                        Padding(
                          padding: const EdgeInsets.only(left: 0, right: 0),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                            ),
                            child: CachedNetworkImage(
                              width: 137,
                              height: 28,
                              imageUrl: requesterCoverImage,
                              errorWidget: (context, url, error) => const Icon(Icons.error, size: 10,),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15,left: 10),
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.blue,
                            foregroundImage: NetworkImage(requesterProfileImage),
                          ),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.05,
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(padding:EdgeInsets.only(left: 5),
                                  child: SizedBox(width:MediaQuery.of(context).size.width * 0.36,child: titleText(requesterVoucherName, size: 8,overflow: TextOverflow.ellipsis)))),
                        ),
                        Positioned(
                          left: MediaQuery.of(context).size.width * 0.25,
                          top: MediaQuery.of(context).size.height * 0.07,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: titleText(requesterVoucherCode, size: 7),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.compare_arrows, color: Colors.black, size: 15,),
                  InkWell(
                    onTap: (){

                      if(isRequesterOrRequestee == 'requestee'){
                        Get.back();
                        var voucherData = {
                          "qrImage" : "assets/images/qr_code.png",
                          "businessName" : model?.requestee?.business == null ? '': model?.requestee?.business?.name ,
                          "expiryDate" : DateFormat("dd/MM/yyyy").format(model!.requesterVoucher!.expiry!),
                          "terms" : model!.requesterVoucher!.termsConditions,
                          "services" : model?.requesterVoucher?.services ,
                          "marketValue" : model!.requesterVoucher!.marketValue ?? '',
                          "tokenCode" : model!.requesterVoucher!.uuId ?? '',
                          "isFree" : model!.requesterVoucher!.isFree,
                          'userId':model!.requesterVoucher!.userId,
                          'voucherId': model!.requesterVoucher!.id,
                          'fromWhere' : 'my_swapped_vouchers'
                        };
                        Get.toNamed('/VoucherDetails', arguments: voucherData);
                      }
                    },
                    child: Stack(
                      children: [
                        Image.asset("assets/images/voucher_card.png", width: 140),
                        Padding(
                          padding: const EdgeInsets.only(left: 0, right: 0),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                            ),
                            child: CachedNetworkImage(
                              width: 137,
                              height: 28,
                              imageUrl: requesteeCoverImage,
                              errorWidget: (context, url, error) => const Icon(Icons.error, size: 10,),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15,left: 10),
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.blue,
                            foregroundImage: NetworkImage(requesteeProfileImage),
                          ),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.05,
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: SizedBox(width: MediaQuery.of(context).size.width * 0.36,child: titleText(requesteeVoucherName, size: 8,overflow: TextOverflow.ellipsis)),
                              )),
                        ),
                        Positioned(
                          left: MediaQuery.of(context).size.width * 0.25,
                          top: MediaQuery.of(context).size.height * 0.07,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: titleText(requesteeVoucherCode, size: 7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5,),
            Row(
              children: [
               showCancelButton == false ? SizedBox(): Expanded(
                  child: InkWell(
                    onTap: cancelPressed,
                    child: Container(
                      height: 45,
                      decoration: const BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12)
                        ),
                      ),
                      child: Center(
                          child: smallText(isRequesterOrRequestee == 'requester'?"Decline":"Cancel", size: 14, clr: primaryColor)),
                    ),
                  ),
                ),
                showOkButton == false ? SizedBox():Expanded(
                  child: InkWell(
                    onTap: oKPressed,
                    child: Container(
                      height: 45,
                      decoration: const BoxDecoration(
                        color: detailsButtonColor,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(12)
                        ),
                      ),
                      child: Center(
                          child: smallText("Accept", size: 14, clr: blackText)),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
