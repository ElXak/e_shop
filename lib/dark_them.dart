import 'package:flutter/material.dart';

import 'constants.dart';

ThemeData darkTheme() {
  return ThemeData.dark().copyWith(
    primaryColorLight: kSecondaryColor,
    textTheme: textTheme(),
    buttonColor: Colors.grey[900],
    shadowColor: Color(0xFF505050).withOpacity(0.2),
    outlinedButtonTheme: outlinedButtonThemeData(),
  );
}

TextTheme textTheme() {
  return TextTheme(
    headline4: kHeadingStyle.copyWith(color: Colors.white),
    headline5: TextStyle(color: Colors.white),
    bodyText1: TextStyle(color: kTextColor),
    bodyText2: TextStyle(color: kTextColor),
    caption: TextStyle(color: Colors.white70),
  );
}

OutlinedButtonThemeData outlinedButtonThemeData() {
  return OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      backgroundColor: Colors.grey[900],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  );
}
