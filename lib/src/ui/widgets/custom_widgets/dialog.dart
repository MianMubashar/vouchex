import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/ui/widgets/custom_widgets/text_widgets.dart';

class AppDialog {
  final String title;
  final String? oKText, cancelText;
  final void Function()? oKPressed, cancelPressed;
  final bool? showCancelButton, showOkButton;
  final String profileImage;
  final String bgImage;
  final String vTitle;
  final String? subtitle;
  final String code;
  AppDialog({
    required this.title,
    this.oKText = 'OK',
    this.cancelText = 'Cancel',
    this.oKPressed,
    this.cancelPressed,
    this.showCancelButton = true,
    this.showOkButton = true,
    required this.bgImage,
    required this.profileImage,
    required this.vTitle,
    this.subtitle,
    required this.code
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
                child: Padding(
                  padding: const EdgeInsets.only(left: 26, right: 26, top: 18, bottom: 18),
                  child: smallText(title),
                ),
            ),
            const SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  titleText("Adidas", size: 16),
                  titleText("You", size: 16),
                ],
              ),
            ),
            const SizedBox(height: 5,),
            Row(
              children: [
                Stack(
                  children: [
                    Image.asset("assets/images/voucher_card.png", width: 170,),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 9),
                      child: Image.asset(bgImage, width: 155,),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15,left: 10),
                      child: Image.asset(profileImage, width: 35, height: 35,),
                    ),
                    Positioned.fill(
                      child: Padding(
                        padding: subtitle != null ? const EdgeInsets.only(left: 20, top: 10) : const EdgeInsets.only(left: 20, top: 30),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: titleText(vTitle, size: 8)),
                      ),
                    ),
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, top: 40),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: cardText(subtitle ?? "", size: 8)),
                      ),
                    ),
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10, right: 20),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: titleText(code, size: 8),
                        ),
                      ),
                    ),
                  ],
                ),
                const Icon(Icons.compare_arrows, color: Colors.black, size: 15,),
                Stack(
                  children: [
                    Image.asset("assets/images/voucher_card.png", width: 170,),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 9),
                      child: Image.asset("assets/images/north9.png", width: 155,),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20,left: 20),
                      child: Image.asset("assets/images/profile_img_1.png", width: 20, height: 20,),
                    ),
                    Positioned.fill(
                      child: Padding(
                        padding: subtitle != null ? const EdgeInsets.only(left: 20, top: 15) : const EdgeInsets.only(left: 20, top: 30),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: titleText("Up to 10% off on per\nProduct", size: 8)),
                      ),
                    ),
                    /*Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, top: 40),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: cardText(subtitle ?? "", size: 8)),
                      ),
                    ),*/
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10, right: 20),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: titleText(code, size: 8),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 5,),
            Row(
              children: [
                Expanded(
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
                          child: smallText("Decline", size: 14, clr: primaryColor)),
                    ),
                  ),
                ),
                Expanded(
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
