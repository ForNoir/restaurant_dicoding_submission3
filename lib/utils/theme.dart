import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var mainColor = const Color(0xFF007D6E);
var secColor = const Color(0xFFFFA317);
var blackColor = const Color(0xFF0F1928);
var whiteColor = const Color(0xFFF3F3F4);
var secBlackColor = const Color(0xFF27303E);
var secWhiteColor = const Color(0xFFE7E8E9);

final TextTheme dipTextTheme = TextTheme(
  headline1: GoogleFonts.montserrat(
      fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headline2: GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.w400),
  headline3: GoogleFonts.montserrat(
      fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  headline4: GoogleFonts.montserrat(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  headline5: GoogleFonts.montserrat(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyText1: GoogleFonts.montserrat(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyText2: GoogleFonts.montserrat(
      fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  button: GoogleFonts.montserrat(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
);

final ThemeData lightTheme = ThemeData(
    primaryColor: mainColor,
    scaffoldBackgroundColor: whiteColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: AppBarTheme(
      backgroundColor: mainColor,
      titleTextStyle: dipTextTheme.headline3!.copyWith(color: whiteColor),
    ));

final ThemeData darkTheme = ThemeData(
    primaryColor: secColor,
    scaffoldBackgroundColor: blackColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: AppBarTheme(
        backgroundColor: secBlackColor,
        titleTextStyle: dipTextTheme.headline3!.copyWith(color: whiteColor)));
