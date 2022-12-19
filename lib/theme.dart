import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColor {
// Colors
  static Color kBlackColor = Colors.black;
  static Color kBlackAccentColor = const Color(0xff161616);
  static Color kGreyColor = const Color(0xff94959B);
  static Color kLineDarkColor = const Color(0xffEAEAEA);
  static Color kWhiteGreyColor = const Color(0xffF1F1F5);
  static Color kWhiteColor = const Color(0xffFFFFFF);
  static Color kRedColor = const Color(0xffFF0000);
  static Color kYellowColor = const Color(0xffFFBA00);
  static Color kBlueColor = Colors.blue;
  static Color kDarkBackgroundPrimaryColor = const Color(0xff1F1D2B);
  static Color kDarkBackgroundColor = const Color(0xff252836);
  static Color kGreenColor = Colors.green;
}

class Style {
// TextStyle
  static TextStyle blackTextStyle = GoogleFonts.poppins(
    color: AppColor.kBlackColor,
  );
  static TextStyle blackAccentTextStyle = GoogleFonts.poppins(
    color: AppColor.kBlackAccentColor,
  );
  static TextStyle greyTextStyle = GoogleFonts.poppins(
    color: AppColor.kGreyColor,
  );
  static TextStyle lineDarkTextStyle = GoogleFonts.poppins(
    color: AppColor.kLineDarkColor,
  );
  static TextStyle whiteGreyTextStyle = GoogleFonts.poppins(
    color: AppColor.kWhiteGreyColor,
  );
  static TextStyle whiteTextStyle = GoogleFonts.poppins(
    color: AppColor.kWhiteColor,
  );
  static TextStyle redTextStyle = GoogleFonts.poppins(
    color: AppColor.kRedColor,
  );
  static TextStyle yellowTextStyle = GoogleFonts.poppins(
    color: AppColor.kYellowColor,
  );
  static TextStyle blueTextStyle = GoogleFonts.poppins(
    color: AppColor.kBlueColor,
  );
  static TextStyle greenTextStyle = GoogleFonts.poppins(
    color: AppColor.kGreenColor,
  );
}

class Weigth {
  // FontWeight
  static FontWeight light = FontWeight.w300;
  static FontWeight regular = FontWeight.w400;
  static FontWeight medium = FontWeight.w500;
  static FontWeight semibold = FontWeight.w600;
  static FontWeight bold = FontWeight.w700;
}
