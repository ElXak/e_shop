import 'package:flutter/material.dart';

import '../../../components/scrolling_body.dart';
import '../../../components/form_builder.dart';
import '../../../enums.dart';
import '../../login_success/login_success_screen.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScrollingBody(
      child: FormBuilder(
        formName: FormName.signIn,
        beforeHeader: 0.04,
        title: 'Welcome Back',
        text:
            'Sign in with your email and password \nor continue with social media',
        afterHeader: 0.08,
        textFields: [
          TextFieldType.email,
          TextFieldType.password,
        ],
        routeName: LoginSuccessScreen.routeName,
      ),
    );
  }
}
