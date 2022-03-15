
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vouchex/src/ui/widgets/custom_widgets/text_widgets.dart';

showInAppNotification({
  required String title,
  required String message,
  String? mainBtnText,
  void Function()? mainBtnPressed,
  String? imgSrc,
  Function(GetSnackBar)? onTap,
  Duration? duration = const Duration(seconds: 3),
}) {
  return Get.snackbar(
    title,
    message,
    backgroundColor: Colors.white,
    colorText: Colors.black87,
    messageText: smallText(message),
    mainButton: TextButton(
      onPressed: mainBtnPressed ?? () => Get.back(),
      child: Text(mainBtnText ?? 'close'),
    ),
    /*icon: Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
            color: Colors.white,
          ),
          child: Icon(
            Icons.notifications,
            color: Colors.black,
          )
        ),
      ],
    ),*/
    margin: const EdgeInsets.all(20),
    isDismissible: true,
    onTap: onTap,
    duration: duration,
  );
}