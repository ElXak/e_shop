import 'package:flutter/material.dart';

import '../constants.dart';
import '../enums.dart';
import '../size_config.dart';
import 'form_error.dart';
import 'default_button.dart';
import 'custom_text_field.dart';
import 'no_account_text.dart';
import 'otp_text_field.dart';
import 'social_row.dart';
import 'form_title.dart';
import 'form_text.dart';
import '../screens/forgot_password/forgot_password_screen.dart';
import 'text_field_properties.dart';

class FormBuilder extends StatefulWidget {
  FormBuilder({
    this.formName,
    this.beforeHeader,
    this.title,
    this.text,
    this.afterHeader,
    this.beforeSubmit,
    this.afterSubmit,
    this.routeName,
    this.textFields,
  });

  final double beforeHeader, afterHeader, beforeSubmit, afterSubmit;
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

  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  FocusNode pin4FocusNode;
  List<FocusNode> focusNodes;

  final List<String> errors = [];
  List<Widget> widgets;

  Map<TextFieldType, TextFieldProperties> _textFieldData;

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    focusNodes = [
      pin2FocusNode,
      pin3FocusNode,
      pin4FocusNode,
    ];
    _textFieldData = {
      TextFieldType.email: TextFieldProperties(
        type: TextFieldType.email,
        label: 'Email',
        hint: 'Enter your email',
        icon: 'assets/icons/Mail.svg',
        validator: (value) {
          if (value.isEmpty) {
            addError(error: kEmailNullError);
            return '';
          } else if (!emailValidatorRegExp.hasMatch(value)) {
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
      TextFieldType.password: TextFieldProperties(
        type: TextFieldType.password,
        label: 'Password',
        hint: 'Enter your password',
        icon: 'assets/icons/Lock.svg',
        validator: (value) {
          if (value.isEmpty) {
            addError(error: kPassNullError);
            return '';
          } else if (value.length < 8) {
            addError(error: kShortPassError);
            return '';
          } else if (widget.textFields
                  .contains(TextFieldType.confirmPassword) &&
              confirmPassword != value) {
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
      TextFieldType.confirmPassword: TextFieldProperties(
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
      TextFieldType.firstName: TextFieldProperties(
        type: TextFieldType.firstName,
        label: 'First Name',
        hint: 'Enter your first name',
        icon: 'assets/icons/User.svg',
        validator: (value) {
          if (value.isEmpty) {
            addError(error: kNameNullError);
            return '';
          }
          return null;
        },
        onChange: (value) {
          if (value.isNotEmpty) {
            removeError(error: kNameNullError);
          }
        },
        onSave: (newValue) => firstName = newValue,
      ),
      TextFieldType.lastName: TextFieldProperties(
        type: TextFieldType.lastName,
        label: 'Last Name',
        hint: 'Enter your last name',
        icon: 'assets/icons/User.svg',
        onSave: (newValue) => lastName = newValue,
      ),
      TextFieldType.phoneNumber: TextFieldProperties(
        type: TextFieldType.phoneNumber,
        label: 'Phone Number',
        hint: 'Enter your phone number',
        icon: 'assets/icons/Phone.svg',
        validator: (value) {
          if (value.isEmpty) {
            addError(error: kPhoneNumberNullError);
            return '';
          }
          return null;
        },
        onChange: (value) {
          if (value.isNotEmpty) {
            removeError(error: kPhoneNumberNullError);
          }
        },
        onSave: (newValue) => phoneNumber = newValue,
      ),
      TextFieldType.address: TextFieldProperties(
        type: TextFieldType.address,
        label: 'Address',
        hint: 'Enter your address',
        icon: 'assets/icons/Location point.svg',
        validator: (value) {
          if (value.isEmpty) {
            addError(error: kAddressNullError);
            return '';
          }
          return null;
        },
        onChange: (value) {
          if (value.isNotEmpty) {
            removeError(error: kAddressNullError);
          }
        },
        onSave: (newValue) => address = newValue,
      ),
    };
  }

  @override
  void dispose() {
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    focusNodes.clear();
    super.dispose();
  }

  OTPTextField buildOPTTextField({int index}) {
    return OTPTextField(
      autofocus: index == 0 ? true : false,
      focusNode: index == 0 ? null : focusNodes[index - 1],
      onChange: (value) {
        //TODO store value
        index < focusNodes.length
            ? nextField(value: value, focusNode: focusNodes[index])
            : focusNodes[index - 1].unfocus();
      },
    );
  }

  void nextField({String value, FocusNode focusNode}) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

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

  CustomTextField buildTextField({TextFieldType textFieldType}) {
    return CustomTextField(
      type: _textFieldData[textFieldType].type,
      label: _textFieldData[textFieldType].label,
      hint: _textFieldData[textFieldType].hint,
      icon: _textFieldData[textFieldType].icon,
      validator: _textFieldData[textFieldType].validator,
      onChange: _textFieldData[textFieldType].onChange,
      onSave: _textFieldData[textFieldType].onSave,
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('This code will expire in '),
        TweenAnimationBuilder(
          tween: Tween(begin: 30.0, end: 0.0),
          duration: Duration(seconds: 30), // because we allow user 30s
          builder: (context, vale, child) => Text(
            '00:${vale.toInt()}',
            style: TextStyle(color: kPrimaryColor),
          ),
          onEnd: () {
            //TODO clear OTP code in server
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    widgets = [
      SizedBox(height: SizeConfig.screenHeight * widget.beforeHeader),
      FormTitle(widget.title),
      FormText(widget.text),
      SizedBox(height: SizeConfig.screenHeight * widget.afterHeader),
    ];

    if (widget.formName == FormName.otp) {
      widgets = [
        ...widgets,
        buildTimer(),
        SizedBox(height: SizeConfig.screenHeight * 0.15),
      ];
    } else {
      widgets = [
        ...widgets,
        ...List.generate(
          widget.textFields.length,
          (index) => buildTextField(
            textFieldType: widget.textFields[index],
          ),
        )
      ];
    }

    if (widget.formName == FormName.signIn)
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
              onTap: () =>
                  Navigator.pushNamed(context, ForgotPasswordScreen.routeName),
              child: Text(
                "Forgot password",
                style: TextStyle(decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      ];

    if (widget.formName == FormName.otp) {
      widgets = [
        ...widgets,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            focusNodes.length + 1,
            (index) => buildOPTTextField(index: index),
          ),
        ),
      ];
    } else {
      widgets = [
        ...widgets,
        FormError(errors: errors),
      ];
    }

    widgets = [
      ...widgets,
      Padding(
        padding: EdgeInsets.only(
          top: pHeight(widget.beforeSubmit),
          bottom: pHeight(widget.afterSubmit),
        ),
        child: DefaultButton(
          text: 'Continue',
          onPress: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              //TODO if everything is valid then go to next screen
              Navigator.pushNamed(context, widget.routeName);
            }
          },
        ),
      ),
    ];

    if (widget.formName == FormName.signUp ||
        widget.formName == FormName.signIn) {
      widgets = [
        ...widgets,
        SocialRow(),
        SizedBox(height: getProportionateScreenHeight(20)),
      ];
    }

    switch (widget.formName) {
      case FormName.signUp:
      case FormName.completeProfile:
        widgets = [
          ...widgets,
          Text(
            'By continuing you confirm that you agree \nwith our Term and Condition',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.caption,
          ),
        ];
        break;
      case FormName.signIn:
      case FormName.forgotPassword:
        widgets = [
          ...widgets,
          NoAccountText(),
        ];
        break;
      case FormName.otp:
        widgets = [
          ...widgets,
          GestureDetector(
            onTap: () {
              //TODO Resend your OTP
            },
            child: Text(
              'Reset OTP Code',
              style: TextStyle(decoration: TextDecoration.underline),
            ),
          ),
        ];
    }

    return Form(
      key: _formKey,
      child: Column(children: widgets),
    );
  }
}
