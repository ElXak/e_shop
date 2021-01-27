import 'package:flutter/material.dart';

import '../../../enums.dart';
import '../../../components/scrolling_body.dart';
import '../../../components/form_builder.dart';
import '../../complete_profile/complete_profile_screen.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScrollingBody(
      child: FormBuilder(
        formName: FormName.signUp,
        beforeHeader: 0.02,
        title: 'Register Account',
        text: 'Complete your details or continue \nwith social media',
        afterHeader: 0.07,
        textFields: [
          TextFieldType.email,
          TextFieldType.password,
          TextFieldType.confirmPassword
        ],
        routeName: CompleteProfileScreen.routeName,
      ),
    );
  }
}
