import 'package:flutter/material.dart';

class FormText extends StatelessWidget {
  const FormText(this.text);

  final text;

  @override
  Widget build(BuildContext context) {
    return Text(text, textAlign: TextAlign.center);
  }
}
