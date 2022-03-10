import 'package:flutter/material.dart';
import 'package:vouchex/src/data/constants.dart';

class SmallButton extends StatelessWidget {
  final String? title;
  final VoidCallback onPress;
  final Color titleColor;
  final double? size;
  final double? height;
  const SmallButton({
    Key? key,
    this.title,
    this.titleColor = whiteText,
    this.size = 14.0,
    this.height = 32,
    required this.onPress
  }): super(key:key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: <Color>[
                Color(0XFFF35A76),
                Color(0XFFE93967)
              ]
          ),
          borderRadius: BorderRadius.all(Radius.circular(5))
      ),
      child: TextButton(
        onPressed: onPress,
        child: Text(
          title ?? '',
          style: TextStyle(fontSize: size, fontWeight: FontWeight.w600, color: titleColor, fontFamily: 'Nunito'),
        ),
      ),
    );
  }
}