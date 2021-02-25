import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../../constants.dart';
import 'components/form_screen.dart';
import 'components/form_text.dart';
import 'components/form_title.dart';
import 'components/otp_text_field.dart';
import 'components/scrolling_body.dart';
import '../../utils/size_config.dart';
import '../components/default_button.dart';

class OTPScreen extends StatefulWidget {
  static String routeName = '/otp';

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final _formKey = GlobalKey<FormState>();

  // String _status = 'no-action';
  bool showSpinner = false;

  List<String> otp = ['0', '0', '0', '0'];

  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  FocusNode pin4FocusNode;
  List<FocusNode> focusNodes;

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
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: FormScreen(
        title: 'OTP Verification',
        body: ScrollingBody(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.05),
                FormTitle('OTP Verification'),
                FormText(
                    'We sent your code to ******086'), //TODO Get phone number from user
                buildTimer(),
                SizedBox(height: SizeConfig.screenHeight * 0.15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    focusNodes.length + 1,
                    (index) => buildOPTTextField(index: index),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: SizeConfig.screenHeight * 0.15,
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

/*
                        _auth
                            .editProfile(
                          userLogin: _formData['login']
                              .toString()
                              .toLowerCase()
                              .trim(),
                          firstName: _formData['firstName'].toString().trim(),
                          lastName: _formData['lastName'].toString().trim(),
                          phoneNumber:
                          _formData['phoneNumber'].toString().trim(),
                          address: _formData['address'].toString().trim(),
                          mailbox: _formData['mailbox'].toString().trim(),
                          zipCode: _formData['zipCode'].toString().trim(),
                        )
                            .then((result) {
                          if (result['result'] == 'OK') {
                            // Navigator.pushNamed(context, OTPScreen.routeName);
                            Navigator.pushNamed(context, HomeScreen.routeName);
                          } else if (result['result'] == 'EMAIL_EXISTS') {
                            addError(
                                error: sprintf(
                                    kEmailExistsError, [_formData['email']]));

                            showSpinner = false;
                          } else {
                            setState(() {
                              // _status = 'rejected';
                              // print(_status);
                              showSpinner = false;
                              errors.clear();
                              String resultMessages =
                              result['strProfileError'].toString();

                              if (resultMessages.contains('\n'))
                                for (String resultMessage
                                in resultMessages.split('\n'))
                                  addError(error: resultMessage);
                              else
                                addError(error: resultMessages);
                            });
                          }
                        });
*/
                      }
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    //TODO Resend your OTP
                  },
                  child: Text(
                    'Reset OTP Code',
                    style: TextStyle(decoration: TextDecoration.underline),
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
