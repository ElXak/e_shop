import 'package:flutter/material.dart';

import '../../../components/scrolling_body.dart';
import '../../../components/form_header.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'otp_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScrollingBody(
      child: Column(
        children: [
          FormHeader(
            before: 0.05,
            title: 'OTP Verification',
            text: 'We sent your code to +992 900 080 ***',
            after: 0,
          ),
          buildTimer(),
          SizedBox(height: SizeConfig.screenHeight * 0.15),
          OtpForm(),
          SizedBox(height: SizeConfig.screenHeight * 0.1), // 10%
          GestureDetector(
            onTap: () {
              //TODO Resend your OTP
            },
            child: Text(
              'Reset OTP Code',
              style: TextStyle(decoration: TextDecoration.underline),
            ),
          ),
        ],
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('This code will expire in '),
        TweenAnimationBuilder(
          tween: Tween(begin: 30.0, end: 0),
          duration: Duration(seconds: 30), // because we allow user 30s
          builder: (context, vale, child) => Text(
            '00:${vale.toInt()}',
            style: TextStyle(color: kPrimaryColor),
          ),
          onEnd: () {
            //TODO clear OTP code in server
          },
        ),
      ],
    );
  }
}
