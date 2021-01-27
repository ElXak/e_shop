import 'package:flutter/material.dart';

import '../size_config.dart';
import 'form_title.dart';
import 'form_text.dart';

class FormHeader extends StatelessWidget {
  FormHeader({
    this.before,
    this.title,
    this.text,
    this.after,
  });

  final String title, text;
  final double before, after;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SizeConfig.screenHeight * before),
        FormTitle(title),
        FormText(text),
        SizedBox(height: SizeConfig.screenHeight * after),
      ],
    );
  }
}
