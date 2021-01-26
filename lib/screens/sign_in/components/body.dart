import 'package:e_shop/enums.dart';
import 'package:flutter/material.dart';

import '../../../components/scrolling_body.dart';
import '../../../components/form_builder.dart';
import '../../login_success/login_success_screen.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScrollingBody(
      child: FormBuilder(
        formName: FormName.signIn,
        title: 'Welcome Back',
        text:
            'Sign in with your email and password \nor continue with social media',
        textFields: [
          TextFieldType.email,
          TextFieldType.password,
        ],
        routeName: LoginSuccessScreen.routeName,
      ),
    );
  }
}
