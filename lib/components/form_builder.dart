import 'package:flutter/material.dart';

import '../constants.dart';
import '../enums.dart';
import '../size_config.dart';
import 'form_error.dart';
import 'default_button.dart';
import 'custom_text_field.dart';
import 'no_account_text.dart';
import 'social_row.dart';
import 'form_title.dart';
import 'form_text.dart';
import '../screens/forgot_password/forgot_password_screen.dart';

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
  }

  @override
  void dispose() {
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    focusNodes.clear();
    super.dispose();
  }

  SizedBox buildOPTTextField({int index}) {
    return SizedBox(
      width: getProportionateScreenWidth(60),
      child: TextFormField(
        autofocus: index == 0 ? true : false,
        focusNode: index == 0 ? null : focusNodes[index - 1],
        obscureText: true,
        keyboardType: TextInputType.number,
        style: TextStyle(fontSize: 24),
        textAlign: TextAlign.center,
        decoration: kOtpInputDecoration,
        onChanged: (value) {
          //TODO store value
          index < focusNodes.length
              ? nextField(value: value, focusNode: focusNodes[index])
              : focusNodes[index - 1].unfocus();
        },
      ),
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

  List<Widget> textFields() {
    List<Widget> listTextFields = [];
    int fieldCounter = 1;
    for (TextFieldType textField in widget.textFields) {
      switch (textField) {
        case TextFieldType.email:
          listTextFields.add(CustomTextField(
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
          listTextFields.add(CustomTextField(
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
          listTextFields.add(CustomTextField(
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
          listTextFields.add(CustomTextField(
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
          listTextFields.add(CustomTextField(
            type: TextFieldType.lastName,
            label: 'Last Name',
            hint: 'Enter your last name',
            icon: 'assets/icons/User.svg',
            onSave: (newValue) => lastName = newValue,
          ));
          break;
        case TextFieldType.phoneNumber:
          listTextFields.add(CustomTextField(
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
          listTextFields.add(CustomTextField(
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
        listTextFields.add(SizedBox(height: getProportionateScreenHeight(30)));
      fieldCounter++;
    }

    return listTextFields;
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('This code will expire in '),
        TweenAnimationBuilder(
          tween: Tween(begin: 30.0, end: 0),
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
        ...textFields(),
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

/*
          [
            OTPTextField(
              autofocus: true,
              onChange: (value) {
                //TODO store value
                nextField(value: value, focusNode: pin2FocusNode);
              },
            ),
            OTPTextField(
              autofocus: false,
              focusNode: pin2FocusNode,
              onChange: (value) {
                //TODO store value
                nextField(value: value, focusNode: pin3FocusNode);
              },
            ),
            OTPTextField(
              autofocus: false,
              focusNode: pin3FocusNode,
              onChange: (value) {
                //TODO store value
                nextField(value: value, focusNode: pin4FocusNode);
              },
            ),
            OTPTextField(
              autofocus: false,
              focusNode: pin4FocusNode,
              onChange: (value) {
                //TODO store value
                pin4FocusNode.unfocus();
              },
            ),
          ],
*/
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
      SizedBox(height: pHeight(widget.beforeSubmit)),
      DefaultButton(
        text: 'Continue',
        onPress: () {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            //TODO if everything is valid then go to next screen
            Navigator.pushNamed(context, widget.routeName);
          }
        },
      ),
      SizedBox(height: pHeight(widget.afterSubmit)),
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
