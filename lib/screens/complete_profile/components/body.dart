import 'package:flutter/material.dart';

import '../../../components/scrolling_body.dart';
import '../../../components/form_builder.dart';
import '../../../enums.dart';
import '../../otp/otp_screen.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScrollingBody(
      child: FormBuilder(
        formName: FormName.completeProfile,
        beforeHeader: 0.04,
        title: 'Complete Profile',
        text: 'Complete your details or continue \nwith social media',
        afterHeader: 0.08,
        textFields: [
          TextFieldType.firstName,
          TextFieldType.lastName,
          TextFieldType.phoneNumber,
          TextFieldType.address,
        ],
        beforeSubmit: 40,
        afterSubmit: 30,
        routeName: OTPScreen.routeName,
      ),
    );
  }
}
