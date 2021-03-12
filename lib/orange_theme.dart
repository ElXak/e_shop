import 'package:flutter/material.dart';

import 'constants.dart';

ThemeData orangeTheme() {
  return ThemeData(
    primaryColor: kPrimaryColor,
    accentColor: kSecondaryColor,
    primaryColorLight: kPrimaryLightColor,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Muli',
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    buttonColor: kSecondaryButtonColor,
    shadowColor: Color(0xFFB0B0B0).withOpacity(0.2),
    outlinedButtonTheme: outlinedButtonThemeData(),
    // buttonTheme: buttonThemeData(),
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: BorderSide(color: kTextColor),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}

OutlinedButtonThemeData outlinedButtonThemeData() {
  return OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      backgroundColor: kPrimaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  );
}

/*
ButtonThemeData buttonThemeData() {
  return ButtonThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    buttonColor: kPrimaryColor,
  );
}
*/

TextTheme textTheme() {
  return TextTheme(
    headline4: kHeadingStyle,
    headline5: TextStyle(color: Colors.black),
    bodyText1: TextStyle(color: kTextColor),
    bodyText2: TextStyle(color: kTextColor),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    centerTitle: true,
    color: Colors.white,
    elevation: 0,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: Colors.black),
    textTheme: TextTheme(
      headline6: TextStyle(color: Color(0xFF8B8B8B), fontSize: 18),
    ),
  );
}
