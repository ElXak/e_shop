import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/form_screen.dart';
import 'components/scrolling_body.dart';
import '../components/default_button.dart';
import 'components/form_title.dart';
import 'components/form_text.dart';
import 'components/form_error.dart';
import 'components/custom_text_field.dart';
import 'components/social_row.dart';
import 'components/no_account_text.dart';
import '../../constants.dart';
import '../../enums.dart';
import '../home/home_screen.dart';
import '../../utils/size_config.dart';
import '../../data/models/auth.dart';
import 'forgot_password_screen.dart';

class SignInScreen extends StatefulWidget {
  static String routeName = '/sign_in';

  final userName;

  SignInScreen({this.userName});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  // String _status = 'no-action';
  bool showSpinner = false;

  final List<String> errors = [];
  Map<String, String> _formData = {};

  TextEditingController _controllerUserName;

  @override
  void initState() {
    _controllerUserName = TextEditingController(text: widget?.userName ?? '');
    _loadUserName();
    super.initState();
    // print(_status);
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

    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: FormScreen(
        title: 'Sign In',
        body: ScrollingBody(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                FormTitle('Welcome Back'),
                FormText(
                    'Sign in with your email and password \nor continue with social media'),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                CustomTextField(
                  type: TextFieldType.email,
                  label: 'Login / Email / Phone number',
                  hint: 'Enter your login, email or phone number',
                  icon: 'assets/icons/Mail.svg',
                  controller: _controllerUserName,
                  validator: (value) {
                    if (value.isEmpty) {
                      addError(error: kLoginEmailPhoneNullError);
                      return '';
                      // } else if (!emailValidatorRegExp.hasMatch(value)) {
                      //   addError(error: kInvalidEmailError);
                      //   return '';
                    }
                    return null;
                  },
                  onChange: (value) {
                    if (value.isNotEmpty) {
                      removeError(error: kLoginEmailPhoneNullError);
                    }
                    // if (emailValidatorRegExp.hasMatch(value)) {
                    //   removeError(error: kInvalidEmailError);
                    // }
                  },
                  onSave: (newValue) => _formData['login'] = newValue,
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
                  },
                  onSave: (newValue) => _formData['password'] = newValue,
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
                Padding(
                  padding: EdgeInsets.only(
                    top: getProportionateScreenHeight(30),
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
                            .login(
                          userLogin: _formData['login']
                              .toString()
                              .toLowerCase()
                              .trim(),
                          userPassword: _formData['password'].toString().trim(),
                        )
                            .then((result) {
                          if (result['result'] == 'AUTH_OK') {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                HomeScreen.routeName,
                                (Route<dynamic> route) => false);
                          } else {
                            setState(() {
                              // _status = 'rejected';
                              // print(_status);
                              showSpinner = false;
                              errors.clear();
                              addError(error: result['message']);
                            });
                          }
                        });
                      }
                    },
                  ),
                ),
                SocialRow(),
                SizedBox(height: getProportionateScreenHeight(20)),
                NoAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}