import 'package:e_shop/screens/splash/components/body.dart';
import 'package:e_shop/size_config.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = '/splash';

  @override
  Widget build(BuildContext context) {
    // You have to call it on starting screen
    SizeConfig().init(context);

    return Scaffold(
      body: Body(),
    );
  }
}
