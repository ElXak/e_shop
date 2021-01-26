import 'package:flutter/material.dart';

import 'components/body.dart';
import '../../components/form_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static String routeName = '/forgot_password';

  @override
  Widget build(BuildContext context) {
    return FormScreen(
      title: 'Forgot Password',
      body: Body(),
    );
  }
}
