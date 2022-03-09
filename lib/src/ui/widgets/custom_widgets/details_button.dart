import 'package:flutter/material.dart';
import 'package:vouchex/src/data/constants.dart';

class DetailsButton extends StatelessWidget {
  final String? title;
  final VoidCallback onPress;
  final Color titleColor;
  const DetailsButton({
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
        width: 382,
        height: 40,
        decoration: const BoxDecoration(
          color: detailsButtonColor,
            borderRadius: BorderRadius.all(Radius.circular(5))
        ),
        child: TextButton(
          onPressed: onPress,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.info_outline, color: Colors.black,),
              const SizedBox(width: 5,),
              Text(
                title ?? '',
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: blackText, fontFamily: 'Nunito'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}