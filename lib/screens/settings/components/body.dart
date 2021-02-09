import 'dart:io';

import 'package:e_shop/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'theme_selector.dart';
import '../../../data/models/auth.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthModel>(context, listen: true);

    return SingleChildScrollView(
      child: SafeArea(
        child: ListBody(
          children: [
            SizedBox(height: 10),
            if (!kIsWeb)
              ListTile(
                leading: Icon(
                  Icons.fingerprint,
                  color: kPrimaryColor,
                  size: 40,
                ),
                title: Text('Enable Biometrics'),
                subtitle: Platform.isIOS
                    ? Text('ToucheID or FaceID')
                    : Text('Fingerprint'),
                trailing: Switch.adaptive(
                  activeColor: kPrimaryColor,
                  inactiveTrackColor: kSecondaryColor,
                  value: _auth.isBioSetup,
                  onChanged: _auth.handleIsBioSetup,
                ),
              ),
            Divider(height: 20),
            ListTile(
              leading: Icon(
                Icons.account_box,
                color: kPrimaryColor,
                size: 40,
              ),
              title: Text('Stay Logged In'),
              subtitle: Text('Logout from the Main Menu'),
              trailing: Switch.adaptive(
                activeColor: kPrimaryColor,
                inactiveTrackColor: kSecondaryColor,
                value: _auth.stayLoggedIn,
                onChanged: _auth.handleStayLoggedIn,
              ),
            ),
            Divider(height: 20),
            ThemeSelector(),
          ],
        ),
      ),
    );
  }
}
