import 'package:flutter/material.dart';

import '../constants.dart';
import '../utils/size_config.dart';

class OTPTextField extends StatelessWidget {
  const OTPTextField({
    Key key,
    this.autofocus,
    this.focusNode,
    this.onChange,
    this.onSave,
  }) : super(key: key);

  final bool autofocus;
  final FocusNode focusNode;
  final Function onChange;
  final Function onSave;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getProportionateScreenWidth(60),
      child: TextFormField(
        autofocus: autofocus,
        focusNode: focusNode,
        obscureText: true,
        keyboardType: TextInputType.number,
        style: TextStyle(fontSize: 24),
        textAlign: TextAlign.center,
        decoration: kOtpInputDecoration,
        onChanged: onChange,
        onSaved: onSave,
      ),
    );
  }
}
