import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../enums.dart';
import '../utils/size_config.dart';
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
import '../data/models/auth.dart';

class FormBuilder extends StatefulWidget {
  FormBuilder({
    this.formName,
    this.beforeHeader,
    this.title,
    this.text,
    this.afterHeader,
    this.beforeSubmit,
    this.afterSubmit,
    this.textFields,
    this.userName,
    this.routeName,
    // this.onPress,
  });

  final double beforeHeader, afterHeader, beforeSubmit, afterSubmit;
  final FormName formName;
  final String title, text;
  final String userName, routeName;
  final List<TextFieldType> textFields;
  // final Function onPress;

  @override
  _FormBuilderState createState() => _FormBuilderState();
}

class _FormBuilderState extends State<FormBuilder> {
  String _status = 'no-action';

  final _formKey = GlobalKey<FormState>();

  Map<String, dynamic> _formData = {'remember': false};
  List<String> otp = ['0', '0', '0', '0'];

  TextEditingController _controllerUserName;

  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  FocusNode pin4FocusNode;
  List<FocusNode> focusNodes;

  final List<String> errors = [];
  List<Widget> widgets;

  Map<TextFieldType, TextFieldProperties> _textFieldParams;

  @override
  void initState() {
    if (widget.formName == FormName.signIn) {
      _controllerUserName = TextEditingController(text: widget?.userName ?? '');
      _loadUserName();
    }
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
    focusNodes = [
      pin2FocusNode,
      pin3FocusNode,
      pin4FocusNode,
    ];
    _textFieldParams = {
      TextFieldType.email: TextFieldProperties(
        type: TextFieldType.email,
        label: 'Email',
        hint: 'Enter your email',
        icon: 'assets/icons/Mail.svg',
        controller: _controllerUserName,
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
        // onSave: (newValue) => _formData.email = newValue,
        onSave: (newValue) => _formData['email'] = newValue,
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
              _formData['confirmPassword'] != value) {
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
          if (_formData['confirmPassword'] == value) {
            removeError(error: kMatchPassError);
          }
          _formData['password'] = value;
        },
        onSave: (newValue) => _formData['password'] = newValue,
      ),
      TextFieldType.confirmPassword: TextFieldProperties(
        type: TextFieldType.password,
        label: 'Confirm Password',
        hint: 'Re-enter your password',
        icon: 'assets/icons/Lock.svg',
        validator: (value) {
          if (_formData['password'] != value) {
            addError(error: kMatchPassError);
            return '';
          }
          return null;
        },
        onChange: (value) {
          if (_formData['password'] == value) {
            removeError(error: kMatchPassError);
          }
          _formData['confirmPassword'] = value;
        },
        onSave: (newValue) => _formData['confirmPassword'] = newValue,
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
        onSave: (newValue) => _formData['firstName'] = newValue,
      ),
      TextFieldType.lastName: TextFieldProperties(
        type: TextFieldType.lastName,
        label: 'Last Name',
        hint: 'Enter your last name',
        icon: 'assets/icons/User.svg',
        onSave: (newValue) => _formData['lastName'] = newValue,
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
        onSave: (newValue) => _formData['phoneNumber'] = newValue,
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
        onSave: (newValue) => _formData['address'] = newValue,
      ),
      TextFieldType.mailbox: TextFieldProperties(
        type: TextFieldType.mailbox,
        label: 'Address 2',
        hint: 'Enter your address 2',
        icon: 'assets/icons/Location point.svg',
        onSave: (newValue) => _formData['address2'] = newValue,
      ),
    };
    print(_status);
  }

  @override
  void dispose() {
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    focusNodes.clear();
    super.dispose();
  }

  void _loadUserName() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      var _userName = _prefs.getString('saved_username') ?? '';
      var _rememberMe = _prefs.getBool('remember_me') ?? false;

      if (_rememberMe) {
        _controllerUserName.text = _userName ?? '';
      }
    } catch (e) {
      print(e);
    }
  }

  OTPTextField buildOPTTextField({int index}) {
    return OTPTextField(
      autofocus: index == 0 ? true : false,
      focusNode: index == 0 ? null : focusNodes[index - 1],
      onChange: (value) {
        //TODO store Entered OTP value
        index < focusNodes.length
            ? nextField(value: value, focusNode: focusNodes[index])
            : focusNodes[index - 1].unfocus();
      },
      onSave: (value) => otp[index] = value,
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
      type: _textFieldParams[textFieldType].type,
      label: _textFieldParams[textFieldType].label,
      hint: _textFieldParams[textFieldType].hint,
      icon: _textFieldParams[textFieldType].icon,
      controller: _textFieldParams[textFieldType].controller,
      validator: _textFieldParams[textFieldType].validator,
      onChange: _textFieldParams[textFieldType].onChange,
      onSave: _textFieldParams[textFieldType].onSave,
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
            //TODO clear OTP code in server and inform user
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthModel>(context, listen: true);

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
              // value: _formData['remember'],
              value: _auth.rememberMe,
              activeColor: kPrimaryColor,
              onChanged: (value) {
                setState(() {
                  // _formData['remember'] = value;
                  _auth.handleRememberMe(value);
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
            setState(() {
              //TODO: Progress Spinner = true
              this._status = 'loading';
            });

            final form = _formKey.currentState;
            if (form.validate()) {
              form.save();

/*
              final snackBar = SnackBar(
                duration: Duration(seconds: 30),
                content: Row(
                  children: [
                    CircularProgressIndicator(),
                    Text('  Logging In...'),
                  ],
                ),
              );
*/

              if (widget.formName == FormName.signIn) {
                _auth
                    .login(
                  userLogin: _formData['email'].toString().toLowerCase().trim(),
                  userPassword: _formData['password'].toString().trim(),
                )
                    .then((result) {
                  if (result['result'] == 'AUTH_OK') {
                    Navigator.pushNamed(context, widget.routeName);
                  } else {
                    setState(() => this._status = 'rejected');
                  }
                });
                //TODO Validate the _formData by DB or json
              } else {
                print(_formData);
                print(otp);
                Navigator.pushNamed(context, widget.routeName);
              }
            }

            setState(() {
              //TODO: Progress Spinner = false
            });
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
