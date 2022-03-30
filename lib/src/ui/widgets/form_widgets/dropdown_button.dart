import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:vouchex/src/data/constants.dart';

class DropDownButton extends StatelessWidget {
  final List list;
  final String name;
  final String? hintText;
  final ValueChanged onChanged;
  final Color? borderColor;
  const DropDownButton({
    Key? key,
    required this.list,
    required this.name,
    this.hintText = 'Select',
    required this.onChanged,
    this.borderColor = secondaryColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: FormBuilderDropdown(
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(color: borderColor!, width: 1)
            ),
            enabledBorder:  OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(color: borderColor!, width: 1)
            ),
            focusedBorder:  OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(color: borderColor!, width: 1)
            ),
            /*labelStyle: TextStyle(fontSize: 14, color: kLabelTextColor, fontFamily: 'Poppins'),
            hintStyle: TextStyle(fontSize: 14, color: kLabelTextColor, fontFamily: 'Poppins')*/
        ),
        icon: const Icon(Icons.keyboard_arrow_down_sharp, color: Colors.black,),
        autofocus: true,
        onChanged: onChanged,
        name: name,
        hint: Text(hintText!),
        items: list
            .map((text) => DropdownMenuItem(
          value: text,
          child: Text(text),
        )).toList(),
      ),
    );
  }
}
