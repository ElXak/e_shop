import 'package:flutter/material.dart';

import '../enums.dart';
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
  }) : super(key: key);

  final TextFieldType type;
  final String label;
  final String hint;
  final String icon;
  final Function validator;
  final Function onChange;
  final Function onSave;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: type == TextFieldType.password ? true : false,
      keyboardType: type == TextFieldType.email
          ? TextInputType.emailAddress
          : TextInputType.text,
      validator: validator,
      onChanged: onChange,
      onSaved: onSave,
      decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSuffixIcon(svgIcon: icon)),
    );
  }
}
