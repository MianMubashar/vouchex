

import 'package:flutter/material.dart';
import 'package:vouchex/src/data/constants.dart';

Text titleText(String text, {double size = 26,FontWeight fontWeight = FontWeight.w700, TextAlign textAlign = TextAlign.start}){
  return Text(text,style: TextStyle(color: blackText,fontSize: size,fontWeight: fontWeight, fontFamily: 'Nunito',), textAlign: textAlign,);
}
Text smallText(String text, {double size = 16, Color clr = greyText, FontWeight fontWeight = FontWeight.w400, TextAlign textAlign = TextAlign.start, TextDecoration decoration = TextDecoration.none}){
  return Text(text,style: TextStyle(color: clr,fontSize: size,fontWeight: fontWeight, fontFamily: 'Nunito', decoration: decoration), textAlign: textAlign,);
}

Text cardText(String text, {double size = 14, Color clr = greyText, FontWeight fontWeight = FontWeight.w300, TextAlign textAlign = TextAlign.start, TextDecoration decoration = TextDecoration.none}){
  return Text(text,style: TextStyle(color: clr,fontSize: size,fontWeight: fontWeight, fontFamily: 'OpenSans', decoration: decoration), textAlign: textAlign,);
}

