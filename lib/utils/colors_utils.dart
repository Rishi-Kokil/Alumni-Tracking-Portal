import 'package:flutter/material.dart';

hexStringToColor(String hexColor){
  hexColor = hexColor.toUpperCase().replaceAll("#" , "");
  if(hexColor.length == 6){
    hexColor = "FF$hexColor";
  }
  return Color(int.parse(hexColor, radix:16));  // Here this method converts integer in Decimal format to Hexadecimal format
}