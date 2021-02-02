import '../enums.dart';

class TextFieldProperties {
  TextFieldProperties({
    this.type,
    this.label,
    this.hint,
    this.icon,
    this.validator,
    this.onChange,
    this.onSave,
  });

  TextFieldType type;
  String label;
  String hint;
  String icon;
  Function validator;
  Function onChange;
  Function onSave;
}
