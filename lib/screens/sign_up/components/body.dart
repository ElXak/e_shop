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
        SizedBox(height: SizeConfig.screenHeight * 0.02),
        Text(
          'Register Account',
          style: headingStyle,
        ),
        Text(
          'Complete your details or continue \nwith social media',
          textAlign: TextAlign.center,
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.07), // 7% of total
        FormBuilder(
          formName: FormName.signUp,
          textFields: [
            TextFieldType.email,
            TextFieldType.password,
            TextFieldType.confirmPassword
          ],
        ),
      ],
    );
  }
}
