import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bluishClr = Color(0xFF64B5F6);
const Color greenishClr = Color(0xFFAED581);
const Color pinkClr = Color(0xFFF48FB1);
const Color white = Colors.white;
const primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
const Color primary = Color(0xFF1FCC79);
const Color Secondary = Color(0xFFFF6464);
const Color purpleClr = Color.fromARGB(255, 220, 51, 0);
const Color orangishClr = Color.fromARGB(255, 246, 142, 94);
Color darkHeaderClr = Color(0xFF424242);

class Themes {
  static final light = ThemeData(
      backgroundColor: Colors.white,
      primaryColor: primaryClr,
      brightness: Brightness.light);

  static final dark = ThemeData(
      backgroundColor: Colors.black,
      primaryColor: darkGreyClr,
      brightness: Brightness.dark);
}

TextStyle get subheadingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Get.isDarkMode ? Colors.grey[400] : Colors.grey));
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Get.isDarkMode ? Colors.white : Colors.black));
}

TextStyle get headingStyle2 {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white));
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Get.isDarkMode ? Colors.white : Colors.black));
}

TextStyle get subTitleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[400]));
}
