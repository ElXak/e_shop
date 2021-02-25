import 'package:flutter/material.dart';

import '../../../utils/size_config.dart';
import '../../components/default_button.dart';
import '../../home/home_screen.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: SizeConfig.screenHeight * 0.04,
            bottom: SizeConfig.screenHeight * 0.08,
          ),
          child: Image.asset(
            'assets/images/success.png',
            height: SizeConfig.screenHeight * 0.4, // 40%
          ),
        ),
        Text(
          'Login Success',
          style: TextStyle(
            fontSize: getProportionateScreenWidth(30),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Spacer(),
        SizedBox(
          width: SizeConfig.screenWidth * 0.6,
          child: DefaultButton(
            text: 'Back to home',
            onPress: () => Navigator.pushNamed(context, HomeScreen.routeName),
          ),
        ),
        Spacer(),
      ],
    );
  }
}