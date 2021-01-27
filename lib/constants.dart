import 'package:flutter/material.dart';

import 'size_config.dart';

const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final kHeadingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

final kOtpInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(
    vertical: getProportionateScreenWidth(15),
  ),
  enabledBorder: kOutlineInputBorder,
  focusedBorder: kOutlineInputBorder,
  border: kOutlineInputBorder,
);

final kOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(15),
  borderSide: BorderSide(color: kTextColor),
);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
final String kEmailNullError = "Please enter your email";
final String kInvalidEmailError = "Please enter valid email";
final String kPassNullError = "Please enter your password";
final String kShortPassError = "Password is too short";
final String kMatchPassError = "Passwords don't match";
final String kNameNullError = "Please enter your name";
final String kPhoneNumberNullError = "Please enter your phone number";
final String kAddressNullError = "Please enter your address";
