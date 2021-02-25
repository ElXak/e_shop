import 'package:flutter/material.dart';

import '../../../enums.dart';

class TextFieldProperties {
  TextFieldProperties({
    this.type,
    this.label,
    this.hint,
    this.icon,
    this.controller,
    this.validator,
    this.onChange,
    this.onSave,
  });

  TextFieldType type;
  String label;
  String hint;
  String icon;
  TextEditingController controller;
  Function validator;
  Function onChange;
  Function onSave;
}
