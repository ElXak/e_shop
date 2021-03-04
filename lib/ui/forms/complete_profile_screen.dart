import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:sprintf/sprintf.dart';
import 'package:date_time_picker/date_time_picker.dart';

import 'components/custom_radio.dart';
import 'components/form_screen.dart';
import 'components/scrolling_body.dart';
import 'components/form_text.dart';
import 'components/form_title.dart';
import 'components/form_error.dart';
import 'components/custom_text_field.dart';
import '../components/default_button.dart';
import '../../constants.dart';
import '../../data/models/auth.dart';
import '../../data/classes/Gender.dart';
import '../../enums.dart';
import '../../utils/size_config.dart';
import '../home/home_screen.dart';

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
    List<String> dateList = date.split('.');
    return '${dateList[2]}-${dateList[1]}-${dateList[0]}';
  }

/*
  @override
  void initState() {
    _controllerBirthday =
        TextEditingController(text: DateTime.now().toString());
    super.initState();
  }
*/

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthModel>(context, listen: true);

    _controllerLogin = TextEditingController(text: _auth.user.login ?? '');
    _controllerEmail = TextEditingController(text: _auth.user.email ?? '');
    _controllerFirstName =
        TextEditingController(text: _auth.user.firstName ?? '');
    _controllerLastName =
        TextEditingController(text: _auth.user.lastName ?? '');

    _birthday = convertDate(_auth.user.birthday) ?? DateTime.now().toString();

    _controllerPhoneNumber =
        TextEditingController(text: _auth.user.phoneNumber ?? '');
    _controllerAddress = TextEditingController(text: _auth.user.address ?? '');
    _controllerMailbox = TextEditingController(text: _auth.user.mailbox ?? '');
    _controllerZipCode = TextEditingController(text: _auth.user.zipCode ?? '');

    _selectedCity = _auth.user.city ?? 'Выберите город';
    _formData['city'] = newCity ?? _selectedCity;

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
                  },
                  onSave: (newValue) => _formData['firstName'] = newValue,
                ),
                CustomTextField(
                  type: TextFieldType.lastName,
                  label: 'Last Name',
                  hint: 'Enter your last name',
                  icon: 'assets/icons/User.svg',
                  controller: _controllerLastName,
                  onSave: (newValue) => _formData['lastName'] = newValue,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Gender:'),
                    Container(
                      // padding: EdgeInsets.all(getProportionateScreenWidth(15)),
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
                                genders['Male'].isSelected = true;
                                genders['Female'].isSelected = false;
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
                                genders['Male'].isSelected = false;
                                genders['Female'].isSelected = true;
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
                  },
                  onSave: (newValue) => _formData['address'] = newValue,
                ),
                CustomTextField(
                  type: TextFieldType.mailbox,
                  label: 'Mailbox',
                  hint: 'Enter your mailbox number',
                  icon: 'assets/icons/Mail.svg',
                  controller: _controllerMailbox,
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
                          // dropdownColor: kPrimaryColor,
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
