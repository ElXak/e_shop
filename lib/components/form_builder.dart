import 'package:flutter/material.dart';

import '../constants.dart';
import '../enums.dart';
import '../size_config.dart';
import 'form_error.dart';
import 'default_button.dart';
import 'custom_text_field.dart';
import 'no_account_text.dart';
import 'social_row.dart';
import '../screens/forgot_password/forgot_password_screen.dart';

class FormBuilder extends StatefulWidget {
  FormBuilder({
    this.formName,
    this.textFields,
    this.routeName,
  });

  final FormName formName;
  final List<TextFieldType> textFields;
  final String routeName;

  @override
  _FormBuilderState createState() => _FormBuilderState();
}

class _FormBuilderState extends State<FormBuilder> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  String confirmPassword;
  bool remember = false;
  final List<String> errors = [];
  final List<Widget> widgets = [];

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

  String validator(value, TextFieldType type) {
    if (type == TextFieldType.email) {
      if (value.isEmpty) {
        addError(error: kEmailNullError);
        return '';
      } else if (!emailValidatorRegExp.hasMatch(value)) {
        addError(error: kInvalidEmailError);
        return '';
      }
    } else if (type == TextFieldType.password) {
      if (value.isEmpty) {
        addError(error: kPassNullError);
        return '';
      } else if (value.length < 8) {
        addError(error: kShortPassError);
        return '';
      } else if (widget.textFields.contains(TextFieldType.confirmPassword) &&
          confirmPassword != value) {
        addError(error: kMatchPassError);
        return '';
      }
    } else if (type == TextFieldType.confirmPassword) {
      if (password != value) {
        addError(error: kMatchPassError);
        return '';
      }
    }
    return null;
  }

  void onChange(value, TextFieldType type) {
    if (type == TextFieldType.email) {
      if (value.isNotEmpty) {
        removeError(error: kEmailNullError);
      }
      if (emailValidatorRegExp.hasMatch(value)) {
        removeError(error: kInvalidEmailError);
      }
    } else if (type == TextFieldType.password) {
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
    } else if (type == TextFieldType.confirmPassword) {
      if (password == value) {
        removeError(error: kMatchPassError);
      }
      confirmPassword = value;
    }
  }

  void addTextFields() {
    int fieldCounter = 1;
    for (TextFieldType textField in widget.textFields) {
      switch (textField) {
        case TextFieldType.email:
          widgets.add(CustomTextField(
            type: TextFieldType.email,
            label: 'Email',
            hint: 'Enter your email',
            icon: 'assets/icons/Mail.svg',
            validator: (value) => validator(value, TextFieldType.email),
            onChange: (value) => onChange(value, TextFieldType.email),
            onSave: (newValue) => email = newValue,
          ));
          break;
        case TextFieldType.password:
          widgets.add(CustomTextField(
            type: TextFieldType.password,
            label: 'Password',
            hint: 'Enter your password',
            icon: 'assets/icons/Lock.svg',
            validator: (value) => validator(value, TextFieldType.password),
            onChange: (value) => onChange(value, TextFieldType.password),
            onSave: (newValue) => password = newValue,
          ));
          break;
        case TextFieldType.confirmPassword:
          widgets.add(CustomTextField(
            type: TextFieldType.password,
            label: 'Confirm Password',
            hint: 'Re-enter your password',
            icon: 'assets/icons/Lock.svg',
            validator: (value) =>
                validator(value, TextFieldType.confirmPassword),
            onChange: (value) => onChange(value, TextFieldType.confirmPassword),
            onSave: (newValue) => confirmPassword = newValue,
          ));
      }

      if (fieldCounter < 4)
        widgets.add(SizedBox(height: getProportionateScreenHeight(30)));
      fieldCounter++;
    }
  }

  @override
  Widget build(BuildContext context) {
    widgets.clear();
    addTextFields();

    if (widget.formName == FormName.signIn) {
      widgets.add(
        Row(
          children: [
            Checkbox(
              value: remember,
              activeColor: kPrimaryColor,
              onChanged: (value) {
                setState(() {
                  remember = value;
                });
              },
            ),
            Text("Remember me"),
            Spacer(),
            GestureDetector(
              onTap: () =>
                  Navigator.pushNamed(context, ForgotPasswordScreen.routeName),
              child: Text(
                "Forgot password",
                style: TextStyle(decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      );
    }

    widgets.add(FormError(errors: errors));

    switch (widget.formName) {
      case FormName.forgotPassword:
        widgets.add(SizedBox(height: SizeConfig.screenHeight * 0.1));
        break;
      default:
        widgets.add(SizedBox(height: getProportionateScreenHeight(30)));
    }

    widgets.add(DefaultButton(
      text: 'Continue',
      onPress: () {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          //TODO if everything is valid then go to success screen
          Navigator.pushNamed(context, widget.routeName);
        }
      },
    ));

    switch (widget.formName) {
      case FormName.forgotPassword:
        widgets.add(SizedBox(height: SizeConfig.screenHeight * 0.1));
        break;
      case FormName.signUp:
        widgets.add(SizedBox(height: SizeConfig.screenHeight * 0.07));
        break;
      case FormName.signIn:
        widgets.add(SizedBox(height: SizeConfig.screenHeight * 0.08));
        break;
    }

    if (widget.formName == FormName.signUp ||
        widget.formName == FormName.signIn) {
      widgets.add(SocialRow());
      widgets.add(SizedBox(height: getProportionateScreenHeight(20)));
    }

    switch (widget.formName) {
      case FormName.forgotPassword:
      case FormName.signIn:
        widgets.add(NoAccountText());
        break;
      case FormName.signUp:
        widgets.add(Text(
          'By continuing you confirm that you agree \nwith our Term and Condition',
          textAlign: TextAlign.center,
        ));
    }

    return Form(
      key: _formKey,
      child: Column(children: widgets),
    );
  }
}
