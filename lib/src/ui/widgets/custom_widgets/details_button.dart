import 'package:flutter/material.dart';
import 'package:vouchex/src/data/constants.dart';

class DetailsButton extends StatelessWidget {
  final String? title;
  final VoidCallback onPress;
  final Color titleColor;
  final Color? buttonColor;
  final bool? showIcon;
  const DetailsButton({
    Key? key,
    this.title,
    this.titleColor = blackText,
    required this.onPress,
    this.buttonColor = detailsButtonColor,
    this.showIcon = true
  }): super(key:key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Container(
        width: 382,
        height: 40,
        decoration:  BoxDecoration(
          color: buttonColor!,
            borderRadius: const BorderRadius.all(Radius.circular(5))
        ),
        child: TextButton(
          onPressed: onPress,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              showIcon == true ? const Icon(Icons.info_outline, color: Colors.black,) : Container(),
              showIcon == true ? const SizedBox(width: 5,) : const SizedBox(),
              Text(
                title ?? '',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: titleColor, fontFamily: 'Nunito'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}