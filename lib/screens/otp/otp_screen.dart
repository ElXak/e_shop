import 'package:flutter/material.dart';

import '../../components/form_screen.dart';
import 'components/body.dart';

class OTPScreen extends StatelessWidget {
  static String routeName = '/otp';

  @override
  Widget build(BuildContext context) {
    return FormScreen(
      title: 'OTP Verification',
      body: Body(),
    );
  }
}
