import 'package:flutter/material.dart';

import '../../utils/size_config.dart';
import 'components/body.dart';

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
