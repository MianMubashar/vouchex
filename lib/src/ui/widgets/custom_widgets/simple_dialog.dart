import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:vouchex/src/ui/widgets/global_widgets.dart';

class ImageDialog {
  final String title;
  final String imageUrl;
  ImageDialog({
    required this.title,
    required this.imageUrl
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
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 15, top: 15),
                child: Container(
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
              ),
            ),
            Image.asset(imageUrl, width: 260, height: 333,),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 26, top: 18, bottom: 18),
              child: titleText(title, size: 20, textAlign: TextAlign.center),
            ),
            const SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }
}
