import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../enums.dart';
import '../../../size_config.dart';
import '../../../components/form_error.dart';
import '../../../components/default_button.dart';
import '../../../components/no_account_text.dart';
import '../../../components/custom_text_field.dart';

class ForgotPassForm extends StatefulWidget {
  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  bool remember = false;
  final List<String> errors = [];

  void addError({String error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            type: TextFieldType.email,
            label: 'Email',
            hint: 'Enter your email',
            icon: 'assets/icons/Mail.svg',
            validator: (value) {
              if (value.isEmpty) {
                addError(error: kEmailNullError);
                return '';
              }
              if (!emailValidatorRegExp.hasMatch(value)) {
                addError(error: kInvalidEmailError);
                return '';
              }
              return null;
            },
            onChange: (value) {
              if (value.isNotEmpty) {
                removeError(error: kEmailNullError);
              }
              if (emailValidatorRegExp.hasMatch(value)) {
                removeError(error: kInvalidEmailError);
              }
            },
            onSave: (newValue) => email = newValue,
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          DefaultButton(
            text: 'Continue',
            onPress: () {
              if (_formKey.currentState.validate()) {
                //TODO Send email with password recovery link
              }
            },
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          NoAccountText(),
        ],
      ),
    );
  }
}
