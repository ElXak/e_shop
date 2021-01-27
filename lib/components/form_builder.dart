import 'package:flutter/material.dart';

import '../constants.dart';
import '../enums.dart';
import '../size_config.dart';
import 'form_error.dart';
import 'default_button.dart';
import 'custom_text_field.dart';
import 'no_account_text.dart';
import 'social_row.dart';
import 'form_header.dart';
import '../screens/forgot_password/forgot_password_screen.dart';

class FormBuilder extends StatefulWidget {
  FormBuilder({
    this.formName,
    this.beforeHeader,
    this.title,
    this.text,
    this.afterHeader,
    this.routeName,
    this.textFields,
  });

  final double beforeHeader, afterHeader;
  final FormName formName;
  final String title, text, routeName;
  final List<TextFieldType> textFields;

  @override
  _FormBuilderState createState() => _FormBuilderState();
}

class _FormBuilderState extends State<FormBuilder> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  String confirmPassword;
  String firstName;
  String lastName;
  String phoneNumber;
  String address;

  bool remember = false;
  final List<String> errors = [];
  List<Widget> widgets;

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
    switch (type) {
      case TextFieldType.email:
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return '';
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return '';
        }
        break;
      case TextFieldType.password:
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
        break;
      case TextFieldType.confirmPassword:
        if (password != value) {
          addError(error: kMatchPassError);
          return '';
        }
        break;
      case TextFieldType.firstName:
        if (value.isEmpty) {
          addError(error: kNameNullError);
          return '';
        }
        break;
      case TextFieldType.phoneNumber:
        if (value.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return '';
        }
        break;
      case TextFieldType.address:
        if (value.isEmpty) {
          addError(error: kAddressNullError);
          return '';
        }
    }

    return null;
  }

  void onChange(value, TextFieldType type) {
    switch (type) {
      case TextFieldType.email:
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        }
        if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        break;
      case TextFieldType.password:
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
        break;
      case TextFieldType.confirmPassword:
        if (password == value) {
          removeError(error: kMatchPassError);
        }
        confirmPassword = value;
        break;
      case TextFieldType.firstName:
        if (value.isNotEmpty) {
          removeError(error: kNameNullError);
        }
        break;
      case TextFieldType.phoneNumber:
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        break;
      case TextFieldType.address:
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
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
          break;
        case TextFieldType.firstName:
          widgets.add(CustomTextField(
            type: TextFieldType.firstName,
            label: 'First Name',
            hint: 'Enter your first name',
            icon: 'assets/icons/User.svg',
            validator: (value) => validator(value, TextFieldType.firstName),
            onChange: (value) => onChange(value, TextFieldType.firstName),
            onSave: (newValue) => firstName = newValue,
          ));
          break;
        case TextFieldType.lastName:
          widgets.add(CustomTextField(
            type: TextFieldType.lastName,
            label: 'Last Name',
            hint: 'Enter your last name',
            icon: 'assets/icons/User.svg',
            onSave: (newValue) => lastName = newValue,
          ));
          break;
        case TextFieldType.phoneNumber:
          widgets.add(CustomTextField(
            type: TextFieldType.phoneNumber,
            label: 'Phone Number',
            hint: 'Enter your phone number',
            icon: 'assets/icons/Phone.svg',
            validator: (value) => validator(value, TextFieldType.phoneNumber),
            onChange: (value) => onChange(value, TextFieldType.phoneNumber),
            onSave: (newValue) => phoneNumber = newValue,
          ));
          break;
        case TextFieldType.address:
          widgets.add(CustomTextField(
            type: TextFieldType.address,
            label: 'Address',
            hint: 'Enter your address',
            icon: 'assets/icons/Location point.svg',
            validator: (value) => validator(value, TextFieldType.address),
            onChange: (value) => onChange(value, TextFieldType.address),
            onSave: (newValue) => address = newValue,
          ));
          break;
      }

      if (fieldCounter < 4)
        widgets.add(SizedBox(height: getProportionateScreenHeight(30)));
      fieldCounter++;
    }
  }

  @override
  Widget build(BuildContext context) {
    widgets = [
      FormHeader(
        before: widget.beforeHeader,
        title: widget.title,
        text: widget.text,
        after: widget.afterHeader,
      ),
    ];

    addTextFields();

    switch (widget.formName) {
      case FormName.signUp:
        widgets = [
          ...widgets,
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButton(
            text: 'Continue',
            onPress: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                //TODO if everything is valid then go to success screen
                Navigator.pushNamed(context, widget.routeName);
              }
            },
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.07),
          SocialRow(),
          SizedBox(height: getProportionateScreenHeight(20)),
          Text(
            'By continuing you confirm that you agree \nwith our Term and Condition',
            textAlign: TextAlign.center,
          ),
        ];
        break;
      case FormName.completeProfile:
        widgets = [
          ...widgets,
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: 'Continue',
            onPress: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                //TODO if everything is valid then go to success screen
                Navigator.pushNamed(context, widget.routeName);
              }
            },
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          Text(
            'By continuing you confirm that you agree \nwith our Term and Condition',
            textAlign: TextAlign.center,
          ),
        ];
        break;
      case FormName.signIn:
        widgets = [
          ...widgets,
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
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: Text(
                  "Forgot password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButton(
            text: 'Continue',
            onPress: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                //TODO if everything is valid then go to success screen
                Navigator.pushNamed(context, widget.routeName);
              }
            },
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.08),
          SocialRow(),
          SizedBox(height: getProportionateScreenHeight(20)),
          NoAccountText(),
        ];
        break;
      case FormName.forgotPassword:
        widgets = [
          ...widgets,
          FormError(errors: errors),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          DefaultButton(
            text: 'Continue',
            onPress: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                //TODO if everything is valid then go to success screen
                Navigator.pushNamed(context, widget.routeName);
              }
            },
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.1),
          NoAccountText(),
        ];
        break;
    }

    return Form(
      key: _formKey,
      child: Column(children: widgets),
    );
  }
}
