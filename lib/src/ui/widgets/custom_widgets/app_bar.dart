import 'package:flutter/material.dart';
import 'package:vouchex/src/data/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final bool showLeadingIcon, showTrailingIcon;
  final void Function()? leadingIconPressed, trailingIconPressed;
  final String? profileImage;
  final TextAlign? textAlign;
   const CustomAppBar({
    Key? key,
    required this.title,
    this.leadingIconPressed,
    this.trailingIconPressed,
    this.showLeadingIcon = false,
    this.showTrailingIcon = false,
    this.profileImage,
    this.textAlign = TextAlign.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 89,
      color: primaryColor,
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 15,
      ),
      child: Row(
        children: [
          showLeadingIcon ?
          IconButton(
            icon: Image.asset('assets/images/back_button.png'),
            onPressed: leadingIconPressed,)
              : const SizedBox(),
          Expanded(
            child: AutoSizeText(
              title,
              maxLines: 2,
              minFontSize: 18,
              maxFontSize: 20,
              overflow: TextOverflow.ellipsis,
              textAlign: textAlign,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 20,
                fontFamily: 'Nunito',
              ),
            ),
          ),
          if (showTrailingIcon)
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage('$profileImage'),
          )
        ],
      ),
    );
  }
}