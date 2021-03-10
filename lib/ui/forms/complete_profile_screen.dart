import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:sprintf/sprintf.dart';

import '../../constants.dart';
import '../../data/classes/Gender.dart';
import '../../data/models/auth.dart';
import '../../enums.dart';
import '../../utils/size_config.dart';
import '../components/default_button.dart';
import '../home/home_screen.dart';
import 'components/custom_radio.dart';
import 'components/custom_text_field.dart';
import 'components/form_error.dart';
import 'components/form_screen.dart';
import 'components/form_text.dart';
import 'components/form_title.dart';
import 'components/scrolling_body.dart';

class CompleteProfileScreen extends StatefulWidget {
  static String routeName = '/complete_profile';

  final userName;

  CompleteProfileScreen({this.userName});

  @override
  _CompleteProfileScreenState createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // String _status = 'no-action';
  bool showSpinner = false;

  final List<String> errors = [];
  final List<String> _cities = [
    'Выберите город',
    'Душанбе',
    'Худжанд',
    'Бохтар',
    'Куляб',
    'Истаравшан',
    'Турсунзаде',
    'Канибадам',
    'Исфара',
    'Гулистон',
    'Вахдат',
    'Пенджикент',
    'Бустон',
    'Хорог',
    'Нурек',
    'Гиссар',
    'Истиклол',
    'Левакант',
    'Рогун',
  ];

  String _selectedCity = "Выберите город";
  String newCity, newBirthday, _birthday;
  String _newLogin,
      _newEmail,
      _newFirstName,
      _newLastName,
      _newGender,
      _newPhoneNumber,
      _newAddress,
      _newMailbox,
      _newZipCode;

  Map<String, String> _formData = {};

  TextEditingController _controllerLogin,
      _controllerEmail,
      _controllerFirstName,
      _controllerLastName,
      _controllerPhoneNumber,
      _controllerAddress,
      _controllerMailbox,
      _controllerZipCode;

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

  String convertDate(String date) {
    if (date == null) {
      return DateTime.now().toString();
    }

    List<String> dateList = date.split('.');
    return '${dateList[2]}-${dateList[1]}-${dateList[0]}';
  }

  TextEditingController _loadController({String fromUser, String fromField}) {
    String controllerText;
    if (fromField != null)
      controllerText = fromField;
    else if (fromUser != null)
      controllerText = fromUser;
    else
      controllerText = '';

    return TextEditingController(text: controllerText);
  }

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthModel>(context, listen: true);

    _controllerLogin =
        _loadController(fromUser: _auth.user.login, fromField: _newLogin);
    _controllerEmail =
        _loadController(fromUser: _auth.user.email, fromField: _newEmail);
    _controllerFirstName = _loadController(
        fromUser: _auth.user.firstName, fromField: _newFirstName);
    _controllerLastName =
        _loadController(fromUser: _auth.user.lastName, fromField: _newLastName);
    _controllerPhoneNumber = _loadController(
        fromUser: _auth.user.phoneNumber, fromField: _newPhoneNumber);
    _controllerAddress =
        _loadController(fromUser: _auth.user.address, fromField: _newAddress);
    _controllerMailbox =
        _loadController(fromUser: _auth.user.mailbox, fromField: _newMailbox);
    _controllerZipCode =
        _loadController(fromUser: _auth.user.zipCode, fromField: _newZipCode);

    _birthday = convertDate(_auth.user.birthday) ?? DateTime.now().toString();

    _selectedCity = _auth.user.city ?? 'Выберите город';
    _formData['city'] = newCity ?? _selectedCity;

    switch (_newGender) {
      case 'M':
        genders['Male'].isSelected = true;
        genders['Female'].isSelected = false;
        break;
      case 'F':
        genders['Male'].isSelected = false;
        genders['Female'].isSelected = true;
        break;
      default:
        if (_auth.user.gender == 'M') {
          genders['Male'].isSelected = true;
          genders['Female'].isSelected = false;
        } else if (_auth.user.gender == 'F') {
          genders['Male'].isSelected = false;
          genders['Female'].isSelected = true;
        } else {
          genders['Male'].isSelected = false;
          genders['Female'].isSelected = false;
        }
    }

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
                FormTitle('Complete Profile'),
                FormText(
                    'Complete your details or continue \nwith social media'),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                CustomTextField(
                  type: TextFieldType.login,
                  label: 'Login',
                  hint: 'Enter your login',
                  icon: 'assets/icons/User.svg',
                  controller: _controllerLogin,
                  validator: (value) {
                    if (value.isEmpty) {
                      addError(error: kLoginNullError);
                      return '';
                      // } else if (!emailValidatorRegExp.hasMatch(value)) {
                      //   addError(error: kInvalidEmailError);
                      //   return '';
                    }
                    return null;
                  },
                  onChange: (value) {
                    if (value.isNotEmpty) {
                      removeError(error: kLoginNullError);
                    }
                    _newLogin = value;
                    // if (emailValidatorRegExp.hasMatch(value)) {
                    //   removeError(error: kInvalidEmailError);
                    // }
                  },
                  onSave: (newValue) => _formData['login'] = newValue,
                ),
                CustomTextField(
                  type: TextFieldType.email,
                  label: 'Email',
                  hint: 'Enter your email',
                  icon: 'assets/icons/Mail.svg',
                  controller: _controllerEmail,
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
                    _newEmail = value;
                  },
                  onSave: (newValue) => _formData['email'] = newValue,
                ),
                CustomTextField(
                  type: TextFieldType.firstName,
                  label: 'First Name',
                  hint: 'Enter your first name',
                  icon: 'assets/icons/User.svg',
                  controller: _controllerFirstName,
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
                    _newFirstName = value;
                  },
                  onSave: (newValue) => _formData['firstName'] = newValue,
                ),
                CustomTextField(
                  type: TextFieldType.lastName,
                  label: 'Last Name',
                  hint: 'Enter your last name',
                  icon: 'assets/icons/User.svg',
                  controller: _controllerLastName,
                  onChange: (value) {
                    _newLastName = value;
                  },
                  onSave: (newValue) => _formData['lastName'] = newValue,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Gender:'),
                    Container(
                      decoration: BoxDecoration(
                        color: kPrimaryLightColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {
                              setState(() {
                                _newGender = 'M';
                                // genders['Male'].isSelected = true;
                                // genders['Female'].isSelected = false;
                              });
                            },
                            child: CustomRadio(
                              gender: genders['Male'],
                              position: 0,
                            ),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {
                              setState(() {
                                _newGender = 'F';
                                // genders['Male'].isSelected = false;
                                // genders['Female'].isSelected = true;
                              });
                            },
                            child: CustomRadio(
                              gender: genders['Female'],
                              position: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                DateTimePicker(
                  type: DateTimePickerType.date,
                  dateMask: 'dd.MM.yyyy',
                  controller:
                      TextEditingController(text: newBirthday ?? _birthday),
                  firstDate: DateTime(1950),
                  lastDate: DateTime.now(),
                  calendarTitle: 'SELECT BIRTHDAY',
                  decoration: InputDecoration(
                    labelText: 'Birthday',
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Icon(Icons.event),
                    ),
                  ),
                  onChanged: (value) {
                    newBirthday = value;
                    _formData['birthday'] = value;
                  },
                  onSaved: (value) => _formData['birthday'] = value,
                ),
                SizedBox(height: 30),
                CustomTextField(
                  type: TextFieldType.phoneNumber,
                  label: 'Phone Number',
                  hint: 'Enter your phone number',
                  icon: 'assets/icons/Phone.svg',
                  controller: _controllerPhoneNumber,
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
                    _newPhoneNumber = value;
                  },
                  onSave: (newValue) => _formData['phoneNumber'] = newValue,
                ),
                CustomTextField(
                  type: TextFieldType.address,
                  label: 'Address',
                  hint: 'Enter your address',
                  icon: 'assets/icons/Location point.svg',
                  controller: _controllerAddress,
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
                    _newAddress = value;
                  },
                  onSave: (newValue) => _formData['address'] = newValue,
                ),
                CustomTextField(
                  type: TextFieldType.mailbox,
                  label: 'Mailbox',
                  hint: 'Enter your mailbox number',
                  icon: 'assets/icons/Mail.svg',
                  controller: _controllerMailbox,
                  onChange: (value) {
                    _newMailbox = value;
                  },
                  onSave: (newValue) => _formData['mailbox'] = newValue,
                ),
                Stack(
                  // fit: StackFit.expand,
                  overflow: Overflow.visible,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: 40, right: 30, top: 10, bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(
                          color: kTextColor,
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          icon: Icon(FontAwesomeIcons.city),
/*
                          selectedItemBuilder: (BuildContext context) {
                            return _cities.map((String value) {
                              return Text(newCity ?? _selectedCity);
                            }).toList();
                          },
*/
                          items: _cities
                              .map(
                                (String dropDownStringItem) =>
                                    DropdownMenuItem<String>(
                                  value: dropDownStringItem,
                                  child: Row(
                                    children: [
                                      Text(dropDownStringItem),
                                    ],
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (!mounted) return;
                            setState(() {
                              newCity = value;
                            });
                            // _formData['city'] = newCity;
                          },
                          value: newCity ?? _selectedCity,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 30,
                      top: -8,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: Text('City'),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 30),
                CustomTextField(
                  type: TextFieldType.zipCode,
                  label: 'Zip Code',
                  hint: 'Enter your Zip Code',
                  icon: 'assets/icons/Mail.svg',
                  controller: _controllerZipCode,
                  onChange: (value) {
                    _newZipCode = value;
                  },
                  onSave: (newValue) => _formData['zipCode'] = newValue,
                ),
                FormError(errors: errors),
                Padding(
                  padding: EdgeInsets.only(
                    top: getProportionateScreenHeight(40),
                    bottom: getProportionateScreenHeight(30),
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

                        if (genders['Male'].isSelected == true) {
                          _formData['gender'] = 'M';
                        } else if (genders['Female'].isSelected == true) {
                          _formData['gender'] = 'F';
                        }

                        final DateTime birthday =
                            DateTime.parse(_formData['birthday']);

                        _auth
                            .editProfile(
                          userLogin: _formData['login']
                              .toString()
                              .toLowerCase()
                              .trim(),
                          userEmail: _formData['email']
                              .toString()
                              .toLowerCase()
                              .trim(),
                          firstName: _formData['firstName'].toString().trim(),
                          lastName: _formData['lastName'].toString().trim(),
                          gender: _formData['gender'],
                          birthday: DateFormat('dd.MM.yyyy').format(birthday),
                          phoneNumber:
                              _formData['phoneNumber'].toString().trim(),
                          address: _formData['address'].toString().trim(),
                          mailbox: _formData['mailbox'].toString().trim(),
                          city: _formData['city'],
                          zipCode: _formData['zipCode'].toString().trim(),
                        )
                            .then((result) {
                          if (result['result'] == 'OK') {
                            // Navigator.pushNamed(context, OTPScreen.routeName);
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                HomeScreen.routeName,
                                (Route<dynamic> route) => false);
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
                      }
                    },
                  ),
                ),
                Text(
                  'By continuing you confirm that you agree \nwith our Term and Condition',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
