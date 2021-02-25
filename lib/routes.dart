import 'package:flutter/widgets.dart';

import 'ui/forms/forgot_password_screen.dart';
import 'ui/forms/sign_in_screen.dart';
import 'ui/splash/splash_screen.dart';
import 'ui/login_success/login_success_screen.dart';
import 'ui/forms/sign_up_screen.dart';
import 'ui/forms/complete_profile_screen.dart';
import 'ui/forms/otp_screen.dart';
import 'ui/home/home_screen.dart';
import 'ui/details/details_screen.dart';
import 'ui/cart/cart_screen.dart';
import 'ui/profile/profile_screen.dart';
import 'ui/settings/settings_screen.dart';

// We use name routes
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OTPScreen.routeName: (context) => OTPScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  SettingsScreen.routeName: (context) => SettingsScreen(),
};
