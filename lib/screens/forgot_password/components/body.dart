import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../enums.dart';
import '../../../size_config.dart';
import '../../../components/scrolling_body.dart';
import '../../../components/form_builder.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScrollingBody(
      children: [
        SizedBox(height: SizeConfig.screenHeight * 0.04),
        Text(
          'Forgot Password',
          style: headingStyle,
        ),
        Text(
          'Please enter your email and we will send \nyou a link to return to your account',
          textAlign: TextAlign.center,
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.1),
        FormBuilder(
          formName: FormName.forgotPassword,
          textFields: [
            TextFieldType.email,
          ],
        ),
      ],
    );
  }
}
