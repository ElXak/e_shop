import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../classes/User.dart';
import '../classes/Gender.dart';
import '../../constants.dart';
import '../../utils/networking.dart';

class AuthModel extends ChangeNotifier {
  String errorMessage = '';

  bool _rememberMe = false;
  bool _stayLoggedIn = true;
  bool _useBio = false;
  User _user;

  bool get rememberMe => _rememberMe;

  void handleRememberMe(bool value) {
    _rememberMe = value;
    notifyListeners();
    SharedPreferences.getInstance()
        .then((prefs) => prefs.setBool('remember_me', value));
  }

  bool get isBioSetup => _useBio;

  void handleIsBioSetup(bool value) {
    _useBio = value;
    notifyListeners();
    SharedPreferences.getInstance()
        .then((prefs) => prefs.setBool('use_bio', value));
  }

  bool get stayLoggedIn => _stayLoggedIn;

  void handleStayLoggedIn(bool value) {
    _stayLoggedIn = value;
    notifyListeners();
    SharedPreferences.getInstance()
        .then((prefs) => prefs.setBool('stay_logged_in', value));
  }

  void loadSettings() async {
    var _prefs = await SharedPreferences.getInstance();
    try {
      _useBio = _prefs.getBool('use_bio') ?? false;
    } catch (e) {
      print(e);
      _useBio = false;
    }
    try {
      _rememberMe = _prefs.getBool('remember_me') ?? false;
    } catch (e) {
      print(e);
      _rememberMe = false;
    }
    try {
      _stayLoggedIn = _prefs.getBool('stay_logged_in') ?? false;
    } catch (e) {
      print(e);
      _stayLoggedIn = false;
    }

    if (_stayLoggedIn) {
      User _savedUser;
      try {
        String _saved = _prefs.getString('user_data');
        print('Saved: $_saved');
        _savedUser = User.fromJson(json.decode(_saved));
      } catch (e) {
        print('User Not Found: $e');
      }
      if (!kIsWeb && _useBio) {
        if (await biometrics()) {
          _user = _savedUser;
        }
      } else {
        _user = _savedUser;
      }
      if (_user.gender == 'M') {
        genders['Male'].isSelected = true;
        genders['Female'].isSelected = false;
      } else if (_user.gender == 'F') {
        genders['Male'].isSelected = false;
        genders['Female'].isSelected = true;
      }
    }
    notifyListeners();
  }

  Future<bool> biometrics() async {
    final LocalAuthentication auth = LocalAuthentication();
    bool authenticated = false;
    try {
      authenticated = await auth.authenticateWithBiometrics(
        localizedReason: 'Scan your fingerprint to authenticate',
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } catch (e) {
      print(e);
    }
    return authenticated;
  }

  User get user => _user;

/*
  Future<User> getInfo(String token) async {
    try {
      //TODO: put relevant url
      var _data = await http.get(kHostURL);
      // var _json = json.decode(json.encode(_data));
      var _newUser = User.fromJson(json.decode(_data.body)['data']);
      _newUser?.token = token;
      return _newUser;
    } catch (e) {
      print("Could Not Load Data: $e");
      return null;
    }
  }
*/

  Future<dynamic> login({
    @required String userLogin,
    @required String userPassword,
  }) async {
    // var uuid = Uuid();
    Map<String, String> postData = {
      'AUTH_FORM': 'Y',
      'USER_LOGIN': userLogin,
      'USER_PASSWORD': userPassword,
    };
    NetworkHelper networkHelper = NetworkHelper(kFormApiUrl, body: postData);
    var serverResponse = await networkHelper.postData();

    // String url =
    //     '$kFormApiUrl?AUTH_FORM=Y&USER_LOGIN=$userLogin&USER_PASSWORD=$userPassword';
    // NetworkHelper networkHelper = NetworkHelper(url);
    // var serverResponse = await networkHelper.getData();

    if (serverResponse == null || serverResponse['result'] == 'AUTH_ERROR')
      return serverResponse;

    // await Future.delayed(Duration(seconds: 3));
    print('Logging In => $userLogin, $userPassword');

    if (_rememberMe) {
      SharedPreferences.getInstance()
          .then((prefs) => prefs.setString('saved_username', userLogin));
    }

    // Get Info For User
    // User _newUser = await getInfo(uuid.v4().toString());
    getUser(serverResponse['user']);

/*
    if (_newUser?.token == null || _newUser.token.isEmpty)
      return serverResponse;
*/
    return serverResponse;
  }

  void getUser(user) {
    User _newUser = User.fromJson(user);
    if (_newUser != null) {
      _user = _newUser;
      notifyListeners();

      SharedPreferences.getInstance().then((prefs) {
        var _save = json.encode(_user.toJson());
        print('Saving User Data: $_save');
        prefs.setString('user_data', _save);
      });
    }
  }

  Future<void> logout() async {
    _user = null;
    notifyListeners();
    SharedPreferences.getInstance()
        .then((prefs) => prefs.setString('user_data', null));
    return;
  }

  bool isEmail(String value) {
    return emailValidatorRegExp.hasMatch(value);
  }

  Future<dynamic> forgotPassword(String userLogin) async {
    Map<String, String> postData = {
      'form_id': 'forgot',
      'TYPE': 'SEND_PWD_AJAX',
      'USER_LOGIN': isEmail(userLogin)
          ? ''
          : userLogin, //TODO: Check if userLogin is Login or Email
      'USER_EMAIL': isEmail(userLogin)
          ? userLogin
          : '', // Check if userLogin is Login or Email
    };

    NetworkHelper networkHelper = NetworkHelper(kFormApiUrl, body: postData);
    var serverResponse = await networkHelper.postData();

    if (serverResponse == null || serverResponse['result'] == 'ERROR')
      return serverResponse;

    print('Password sent to => $userLogin');

    return serverResponse;
  }

  Future<dynamic> sigUp({
    @required String userEmail,
    @required String userPassword,
    @required String confirmPassword,
    String captchaSid,
    String captcha,
  }) async {
    Map<String, String> postData = {
      'form_id': 'reg',
      'REGISTER[EMAIL]': userEmail,
      'REGISTER[PASSWORD]': userPassword,
      'REGISTER[CONFIRM_PASSWORD]': confirmPassword,
      'captcha_sid': captchaSid,
      'captcha_word': captcha,
    };
    NetworkHelper networkHelper = NetworkHelper(kFormApiUrl, body: postData);
    var serverResponse = await networkHelper.postData();

    if (serverResponse == null ||
        serverResponse['result'] == 'ERROR' ||
        serverResponse['result'] == 'EMAIL_EXISTS') return serverResponse;

    if (_rememberMe) {
      SharedPreferences.getInstance()
          .then((prefs) => prefs.setString('saved_username', userEmail));
    }

    getUser(serverResponse['user']);

    return serverResponse;
  }

  Future<dynamic> editProfile({
    @required String userLogin,
    @required String userEmail,
    @required String firstName,
    String lastName,
    String gender,
    @required String phoneNumber,
    @required String address,
    String mailbox,
    String zipCode,
  }) async {
    var sessionData = await getSession();
    Map<String, String> postData = {
      'sessid': sessionData['session_id'],
      'ID': _user.id,
      'LOGIN': userLogin,
      'EMAIL': _user.email,
      'NAME': firstName,
      'LAST_NAME': lastName,
      'PERSONAL_GENDER': gender,
      'PERSONAL_PHONE': phoneNumber,
      'PERSONAL_STREET': address,
      'PERSONAL_MAILBOX': mailbox,
      'PERSONAL_ZIP': zipCode,
      'save': 'Save profile',
    };

    NetworkHelper networkHelper = NetworkHelper(kProfileUrl, body: postData);
    var serverResponse = await networkHelper.postData();

    if (serverResponse == null ||
        serverResponse['strProfileError'] != '' ||
        serverResponse['result'] == 'NOT_AUTHORIZED') return serverResponse;

    if (_rememberMe) {
      SharedPreferences.getInstance()
          .then((prefs) => prefs.setString('saved_username', userLogin));
    }

    getUser(serverResponse['arUser']);

    return serverResponse;
  }

  Future<dynamic> getCaptchaSid() async {
    NetworkHelper networkHelper = NetworkHelper(kCaptchaCodeUrl);
    var serverResponse = await networkHelper.getData();

    // notifyListeners();

    if (serverResponse == null) return {'result': 'ERROR'};
    return serverResponse;
  }

  Future<dynamic> getSession() async {
    NetworkHelper networkHelper = NetworkHelper(kSessionIdUrl);
    var serverResponse = await networkHelper.getData();

    // notifyListeners();

    if (serverResponse == null) return {'result': 'ERROR'};
    return serverResponse;
  }
}
