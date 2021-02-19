import 'package:flutter/material.dart';

class FormTitle extends StatelessWidget {
  const FormTitle(this.text);

  final text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.headline4);
  }
}
