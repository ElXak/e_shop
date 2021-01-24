import 'package:e_shop/screens/forgot_password/forgot_password_screen.dart';
import 'package:e_shop/screens/sign_in/sign_in_screen.dart';
import 'package:e_shop/screens/splash/splash_screen.dart';
import 'package:flutter/widgets.dart';

// We use name routes
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
};
