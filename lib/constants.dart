import 'package:flutter/material.dart';

import 'utils/size_config.dart';

const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), kPrimaryColor],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);
const kSecondaryButtonColor = Color(0xFFF5F6F9);
// const kCardColor = Color(0xFFF6F7F9);

const kAnimationDuration = Duration(milliseconds: 200);
const kDefaultDuration = Duration(milliseconds: 250);

final kHeadingStyle = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

final kOtpInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(
    vertical: getProportionateScreenWidth(15),
  ),
  border: kOutlineInputBorder,
  enabledBorder: kOutlineInputBorder,
  focusedBorder: kOutlineInputBorder,
);

final kOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
  borderSide: BorderSide(color: kTextColor),
);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kLoginNullError = "Please enter your login";
const String kEmailNullError = "Please enter your email";
const String kLoginEmailPhoneNullError =
    "Please enter your login, email or phone number";
const String kInvalidEmailError = "Please enter valid email";
const String kEmailExistsError =
    "Пользователь с таким e-mail (%s) уже существует.";
const String kPassNullError = "Please enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kCaptchaNullError = "Please enter captcha";
const String kNameNullError = "Please enter your name";
const String kPhoneNumberNullError = "Please enter your phone number";
const String kAddressNullError = "Please enter your address";

const String kHostURL = 'lamode.tj';
const String kFormApiUrl = '/json/auth.php';
const String kCaptchaCodeUrl = '/json/captcha.php';
const String kCaptchaImageUrl =
    'https://lamode.tj/bitrix/tools/captcha.php?captcha_sid=';
const String kSessionIdUrl = '/json/session.php';
const String kProfileUrl = '/json/profile.php';
