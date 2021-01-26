import 'package:e_shop/components/form_builder.dart';
import 'package:e_shop/enums.dart';
import 'package:flutter/material.dart';

import '../../../components/scrolling_body.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScrollingBody(
      child: FormBuilder(
        formName: FormName.completeProfile,
        title: 'Complete Profile',
        text: 'Complete your details or continue \nwith social media',
        textFields: [
          TextFieldType.firstName,
          TextFieldType.lastName,
          TextFieldType.phoneNumber,
          TextFieldType.address,
        ],
      ),
    );
  }
}
