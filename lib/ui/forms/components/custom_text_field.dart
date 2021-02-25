import 'package:flutter/material.dart';

import '../../../enums.dart';
import '../../../utils/size_config.dart';
import 'custom_suffix_icon.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key key,
    this.type,
    this.label,
    this.hint,
    this.icon,
    this.validator,
    this.onChange,
    this.onSave,
    this.controller,
  }) : super(key: key);

  final TextFieldType type;
  final String label;
  final String hint;
  final String icon;
  final Function validator;
  final Function onChange;
  final Function onSave;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    TextInputType inputType;

    switch (type) {
      case TextFieldType.email:
        inputType = TextInputType.emailAddress;
        break;
      case TextFieldType.phoneNumber:
      case TextFieldType.captcha:
      case TextFieldType.mailbox:
      case TextFieldType.zipCode:
        inputType = TextInputType.number;
        break;
      default:
        inputType = TextInputType.text;
    }

    return Padding(
      padding: EdgeInsets.only(bottom: getProportionateScreenHeight(30)),
      child: TextFormField(
        obscureText: type == TextFieldType.password ? true : false,
        keyboardType: inputType,
        controller: controller,
        validator: validator,
        onChanged: onChange,
        onSaved: onSave,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSuffixIcon(svgIcon: icon),
        ),
      ),
    );
  }
}
