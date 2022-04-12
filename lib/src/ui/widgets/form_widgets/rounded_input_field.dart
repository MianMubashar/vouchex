import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:vouchex/src/data/constants.dart';

class RoundedInputField extends StatelessWidget {
  final String? hintText, name, labelText;
  final bool obscureText;
  final bool readOnly;
  final IconData? icon;
  final IconData? suffixIcon;
  final VoidCallback? suffixIconPressed;
  final TextInputType? keyboardType;
  final TextEditingController? textEditingController;
  final TextInputAction? textInputAction;
  final void Function(String?)? onSubmitted;
  final ValueChanged<String?>? onChanged;
  final String? Function(String?)? validator;
  final int? maxLine;
  final Color? fillColor;
  final Color? borderColor;
  const RoundedInputField({
    Key? key,
    this.hintText,
    this.obscureText = false,
    this.readOnly = false,
    this.labelText,
    this.name,
    this.icon,
    this.suffixIcon,
    this.suffixIconPressed,
    this.keyboardType,
    this.textEditingController,
    this.textInputAction = TextInputAction.done,
    this.onSubmitted,
    this.onChanged,
    this.validator,
    this.maxLine = 1,
    this.fillColor = secondaryColor,
    this.borderColor = secondaryColor
  }) : super(key:key);
  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      controller: textEditingController,
      name: name ?? '',
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      validator: validator,
      readOnly: readOnly,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      maxLines: maxLine,
      decoration: InputDecoration(
        prefixIcon: icon!= null
            ? Icon(
          icon,
          color: primaryColor,
          size: 30,
        ): null,
        suffixIcon: suffixIcon!= null ?
            IconButton(
              onPressed: suffixIconPressed,
              icon: Icon(suffixIcon, color: Colors.black, size: 15,),
            ) : null,
        hintText: hintText,
        labelText: labelText,
        filled: true,
        fillColor: fillColor,
          border:  OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(26)),
              borderSide: BorderSide(color: borderColor!, width: 1)
          ),
          enabledBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(26)),
              borderSide: BorderSide(color: borderColor!, width: 1)
          ),
          focusedBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(26)),
              borderSide: BorderSide(color: borderColor!, width: 1)
          ),
        labelStyle: const TextStyle(fontSize: 16, color: greyText, fontFamily: 'Nunito'),
        hintStyle: const TextStyle(fontSize: 16, color: greyText, fontFamily: 'Nunito')
      ),
    );
  }
}
