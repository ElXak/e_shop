import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:sprintf/sprintf.dart';

import '../../components/form_screen.dart';
import '../../components/scrolling_body.dart';
import '../../components/form_text.dart';
import '../../components/form_title.dart';
import '../../components/form_error.dart';
import '../../components/custom_text_field.dart';
import '../../components/default_button.dart';
import '../../constants.dart';
import '../../data/models/auth.dart';
import '../../enums.dart';
import '../../utils/size_config.dart';
import '../complete_profile/complete_profile_screen.dart';
// import '../forgot_password/forgot_password_screen.dart';

class SignUpScreen extends StatefulWidget {
  static String routeName = '/sign_up';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String captchaSid;

  // String _status = 'no-action';
  bool showSpinner = false;

  final List<String> errors = [];
  Map<String, String> _formData = {};

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
    final _auth = Provider.of<AuthModel>(context, listen: true);
    captchaSid = _auth.getCaptchaSid().toString();

    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: FormScreen(
        title: 'Sign Up',
        body: ScrollingBody(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                FormTitle('Register Account'),
                FormText(
                    'Complete your details or continue \nwith social media'),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                CustomTextField(
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
                  onSave: (newValue) => _formData['email'] = newValue,
                ),
                CustomTextField(
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
                    } else if (_formData['confirmPassword'] != value) {
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
                CustomTextField(
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
                Padding(
                  padding:
                      EdgeInsets.only(bottom: getProportionateScreenHeight(30)),
                  child: SizedBox(
                    width: double.infinity,
                    child: Image.network(
                      kCaptchaImageUrl + captchaSid,
                      fit: BoxFit.fitWidth,
                    ),
                    // child: Image.network(
                    //   kCaptchaImageUrl + captchaSid,
                    //   fit: BoxFit.fitWidth,
                    // ),
                  ),
                ),
                CustomTextField(
                  type: TextFieldType.captcha,
                  label: 'Captcha',
                  hint: 'Enter Captcha',
                  icon: 'assets/icons/Lock.svg',
                  validator: (value) {
                    if (value.isEmpty) {
                      addError(error: kCaptchaNullError);
                      return '';
                    }
                    return null;
                  },
                  onChange: (value) {
                    if (value.isNotEmpty) {
                      removeError(error: kCaptchaNullError);
                    }
                  },
                  onSave: (newValue) => _formData['captcha'] = newValue,
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _auth.rememberMe,
                      activeColor: kPrimaryColor,
                      onChanged: (value) {
                        setState(() {
                          _auth.handleRememberMe(value);
                        });
                      },
                    ),
                    Text("Remember me"),
                  ],
                ),
                FormError(errors: errors),
                Padding(
                  padding: EdgeInsets.only(
                    top: getProportionateScreenHeight(40),
                    bottom: SizeConfig.screenHeight * 0.08,
                  ),
                  child: DefaultButton(
                    text: 'Continue',
                    onPress: () {
                      final form = _formKey.currentState;

                      if (form.validate()) {
                        setState(() {
                          showSpinner = true;
                          // _status = 'loading';
                          // print(_status);
                        });

                        form.save();

                        _auth
                            .sigUp(
                          userEmail: _formData['email']
                              .toString()
                              .toLowerCase()
                              .trim(),
                          userPassword: _formData['password'].toString().trim(),
                          confirmPassword:
                              _formData['confirmPassword'].toString().trim(),
                          captchaSid: captchaSid,
                          captcha: _formData['captcha'].toString().trim(),
                        )
                            .then((result) {
                          if (result['result'] == 'OK') {
                            Navigator.pushNamed(
                                context, CompleteProfileScreen.routeName);
                          } else if (result['result'] == 'EMAIL_EXISTS') {
                            addError(
                                error: sprintf(
                                    kEmailExistsError, [_formData['email']]));

                            showSpinner = false;

/*
                            setState(() {
                              imageCache.clear();
                              imageCache.clearLiveImages();
                              captchaSid = _auth.getCaptcha().toString();
                              showSpinner = false;
                            });
*/

/*
                            Navigator.pushNamed(
                              context,
                              ForgotPasswordScreen.routeName,
                              arguments: ForgotPasswordArguments(
                                errorMessage: sprintf(
                                  kEmailExistsError,
                                  [_formData['email']],
                                ),
                              ),
                            );
*/
                          } else {
                            setState(() {
                              // _status = 'rejected';
                              // print(_status);
                              showSpinner = false;
                              errors.clear();
                              String resultMessages =
                                  result['message'].toString();

                              if (resultMessages.contains('\n'))
                                for (String resultMessage
                                    in resultMessages.split('\n'))
                                  addError(error: resultMessage);
                              else
                                addError(error: resultMessages);
                            });
                          }
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
