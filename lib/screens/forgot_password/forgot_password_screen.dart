import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/form_screen.dart';
import '../../components/scrolling_body.dart';
import '../../components/form_text.dart';
import '../../components/form_title.dart';
import '../../components/form_error.dart';
import '../../components/custom_text_field.dart';
import '../../components/default_button.dart';
import '../../components/no_account_text.dart';
import '../../constants.dart';
import '../../enums.dart';
import '../../utils/size_config.dart';
import '../../data/models/auth.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static String routeName = '/forgot_password';

  final String userName;

  ForgotPasswordScreen({
    this.userName,
  });

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
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

/*
    final ForgotPasswordArguments args =
        ModalRoute.of(context).settings.arguments;

    if (args.errorMessage.isNotEmpty) addError(error: args.errorMessage);
*/

    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: FormScreen(
        title: 'Forgot Password',
        body: ScrollingBody(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                FormTitle('Forgot Password'),
                FormText(
                    'Please enter your email and we will send \nyou a link to return to your account'),
                SizedBox(height: SizeConfig.screenHeight * 0.1),
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
                FormError(errors: errors),
                Padding(
                  padding: EdgeInsets.only(
                    top: SizeConfig.screenHeight * 0.1,
                    bottom: SizeConfig.screenHeight * 0.1,
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
                            .forgotPassword(_formData['login']
                                .toString()
                                .toLowerCase()
                                .trim())
                            .then((result) {
                          if (result['result'] == 'OK') {
                            addError(error: result['message']);
                            showSpinner = false;
/*
                            Navigator.pushNamed(
                              context,
                              SignInScreen.routeName,
                            );
*/
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
                NoAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*
// Arguments class for receiving product via named Route
class ForgotPasswordArguments {
  final String errorMessage;

  ForgotPasswordArguments({
    @required this.errorMessage,
  });
}
*/
