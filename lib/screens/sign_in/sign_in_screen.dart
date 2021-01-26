import 'package:flutter/material.dart';

import 'components/body.dart';
import '../../components/form_screen.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = '/sign_in';

  @override
  Widget build(BuildContext context) {
    return FormScreen(
      title: 'Sign In',
      body: Body(),
    );
  }
}
