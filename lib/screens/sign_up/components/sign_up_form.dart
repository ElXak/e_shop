import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../enums.dart';
import '../../../size_config.dart';
import '../../../components/form_error.dart';
import '../../../components/default_button.dart';
import '../../../components/custom_text_field.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  String confirmPassword;
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
          CustomTextField(
            type: TextFieldType.password,
            label: 'Password',
            hint: 'Enter your password',
            icon: 'assets/icons/Lock.svg',
            validator: (value) {
              if (value.isEmpty) {
                addError(error: kPassNullError);
                return '';
              }
              if (value.length < 8) {
                addError(error: kShortPassError);
                return '';
              }
              if (confirmPassword != value) {
                addError(error: kMatchPassError);
                return '';
              }
              return null;
            },
            onChange: (value) {
              if (value.isNotEmpty) {
                removeError(error: kPassNullError);
              }
              if (value.length >= 8) {
                removeError(error: kShortPassError);
              }
              if (confirmPassword == value) {
                removeError(error: kMatchPassError);
              }
              password = value;
            },
            onSave: (newValue) => password = newValue,
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          CustomTextField(
            type: TextFieldType.password,
            label: 'Confirm Password',
            hint: 'Re-enter your password',
            icon: 'assets/icons/Lock.svg',
            validator: (value) {
              if (password != value) {
                addError(error: kMatchPassError);
                return '';
              }
              return null;
            },
            onChange: (value) {
              if (password == value) {
                removeError(error: kMatchPassError);
              }
              confirmPassword = value;
            },
            onSave: (newValue) => confirmPassword = newValue,
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButton(
            text: 'Continue',
            onPress: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                //TODO if everything is valid then go to complete profile screen
                // Navigator.pushNamed(context, LoginSuccessScreen.routeName);
              }
            },
          )
        ],
      ),
    );
  }
}
