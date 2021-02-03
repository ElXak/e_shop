import 'package:flutter/material.dart';

import '../../../components/scrolling_body.dart';
import '../../../components/form_builder.dart';
import '../../../enums.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScrollingBody(
      child: FormBuilder(
        formName: FormName.otp,
        beforeHeader: 0.05,
        title: 'OTP Verification',
        text:
            'We sent your code to ******086', //TODO Get phone number from user
        afterHeader: 0,
        beforeSubmit: 0.15,
        afterSubmit: 0.1,
      ),
    );
  }
}
