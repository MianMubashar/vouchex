import 'package:flutter/material.dart';
import 'package:vouchex/src/data/constants.dart';

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
        horizontal: 10,
      ),
      child: Row(
        children: [
          showLeadingIcon ?
          IconButton(
            icon: Image.asset('assets/images/back_button.png'),
            onPressed: leadingIconPressed,)
              : const SizedBox(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                title,
                textAlign: textAlign,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  fontFamily: 'Nunito',
                ),
              ),
            ),
          ),
          if (showTrailingIcon)
            /*IconButton(
              icon: Image.network('$profileImage'),
              onPressed: trailingIconPressed,
            ),*/
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