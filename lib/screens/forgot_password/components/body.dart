import 'package:flutter/material.dart';

import '../../../enums.dart';
import '../../../components/scrolling_body.dart';
import '../../../components/form_builder.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScrollingBody(
      child: FormBuilder(
        formName: FormName.forgotPassword,
        beforeHeader: 0.04,
        title: 'Forgot Password',
        text:
            'Please enter your email and we will send \nyou a link to return to your account',
        afterHeader: 0.1,
        textFields: [
          TextFieldType.email,
        ],
        beforeSubmit: 0.1,
        afterSubmit: 0.1,
      ),
    );
  }
}
