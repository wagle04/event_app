import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF333697);

  static const Color secondaryColor = Color(0xFFD1D3D4);

  static const Color primaryTextColor = Color(0xFF1D1F33);

  static const Color scaffoldBodyColor = Colors.white;

  static const primaryIconColor = Colors.grey;

  static const Color textColor = Color(0xFF1D1F33);

  static TextTheme mainTextTheme = GoogleFonts.montserratTextTheme(textTheme);

  static const defaultPadding = EdgeInsets.symmetric(horizontal: 30.0);

  static TextStyle testStyle1 = GoogleFonts.montserrat(
    color: primaryTextColor,
    fontSize: 14,
  );

  static TextStyle testStyle2 = GoogleFonts.montserrat(
    color: Colors.grey,
    fontSize: 14,
  );

  static const TextTheme textTheme = TextTheme(
    bodyText1: TextStyle(
      color: primaryTextColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  );

  static ThemeData themeData = ThemeData(
    appBarTheme: AppBarTheme(
      actionsIconTheme: const IconThemeData(color: textColor),
      color: Colors.white,
      iconTheme: const IconThemeData(color: textColor),
      centerTitle: true,
      titleTextStyle: GoogleFonts.montserrat(
        color: primaryTextColor,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    primaryColor: primaryColor,
    textTheme: mainTextTheme,
    iconTheme: const IconThemeData(
      color: primaryIconColor,
      size: 25,
    ),
  );
}
