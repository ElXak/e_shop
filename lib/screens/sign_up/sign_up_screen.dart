import 'package:flutter/material.dart';

import 'components/body.dart';
import '../../components/form_screen.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = '/sign_up';

  @override
  Widget build(BuildContext context) {
    return FormScreen(
      title: 'Sign Up',
      body: Body(),
    );
  }
}
