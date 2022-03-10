import 'package:flutter/material.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/ui/widgets/custom_widgets/text_widgets.dart';

class AppDialog {
  final String title;
  final String? oKText, cancelText;
  final void Function()? oKPressed, cancelPressed;
  final bool? showCancelButton, showOkButton;
  AppDialog({
    required this.title,
    this.oKText = 'OK',
    this.cancelText = 'Cancel',
    this.oKPressed,
    this.cancelPressed,
    this.showCancelButton = true,
    this.showOkButton = true,
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
                          onPressed: (){},
                          icon: const Icon(Icons.clear, size: 20, color: primaryColor,),
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
