import 'package:flutter/material.dart';

import 'constants.dart';

ThemeData darkTheme() {
  return ThemeData.dark().copyWith(
    textTheme: textTheme(),
    buttonColor: Colors.grey[900],
    shadowColor: Color(0xFF505050).withOpacity(0.2),
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
