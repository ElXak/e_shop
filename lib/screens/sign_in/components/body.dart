import 'package:e_shop/enums.dart';
import 'package:flutter/material.dart';

import '../../../components/scrolling_body.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import '../../../components/form_builder.dart';
import '../../login_success/login_success_screen.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScrollingBody(
      children: [
        SizedBox(height: SizeConfig.screenHeight * 0.04),
        Text(
          'Welcome Back',
          style: headingStyle,
        ),
        Text(
          'Sign in with your email and password \nor continue with social media',
          textAlign: TextAlign.center,
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.08),
        FormBuilder(
          formName: FormName.signIn,
          textFields: [
            TextFieldType.email,
            TextFieldType.password,
          ],
          routeName: LoginSuccessScreen.routeName,
        ),
      ],
    );
  }
}
