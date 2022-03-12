import 'package:flutter/material.dart';
import 'package:vouchex/src/data/constants.dart';

class RoundedRectangleButton extends StatelessWidget {
  final String? title;
  final VoidCallback onPress;
  final Color titleColor;
  const RoundedRectangleButton({
    Key? key,
    this.title,
    this.titleColor = whiteText,
    required this.onPress
  }): super(key:key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Container(
        width: 385,
        height: 50,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Color(0XFFF35A76),
              Color(0XFFE93967)
            ]
          ),
          borderRadius: BorderRadius.all(Radius.circular(30))
        ),
        child: TextButton(
          onPressed: onPress,
          child: Text(
            title ?? '',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: titleColor, fontFamily: 'Nunito'),
          ),
        ),
      ),
    );
  }
}

class RoundedButtonSolidColor extends StatelessWidget {
  final String? title;
  final VoidCallback onPress;
  final Color titleColor;
  const RoundedButtonSolidColor({
    Key? key,
    this.title,
    this.titleColor = primaryColor,
    required this.onPress
  }): super(key:key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Container(
        width: 385,
        height: 46,
        decoration: const BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.all(Radius.circular(76))
        ),
        child: TextButton(
          onPressed: onPress,
          child: Text(
            title ?? '',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: titleColor, fontFamily: 'Nunito'),
          ),
        ),
      ),
    );
  }
}