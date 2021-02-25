import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'custom_switch.dart';
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
              CustomSwitch(
                icon: Icons.fingerprint,
                title: 'Enable Biometrics',
                subtitle: Platform.isIOS ? 'ToucheID or FaceID' : 'Fingerprint',
                value: _auth.isBioSetup,
                onChange: _auth.handleIsBioSetup,
              ),
            Divider(height: 20),
            CustomSwitch(
              icon: Icons.account_box,
              title: 'Stay Logged In',
              subtitle: 'Logout from the Main Menu',
              value: _auth.stayLoggedIn,
              onChange: _auth.handleStayLoggedIn,
            ),
            Divider(height: 20),
            ThemeSelector(),
          ],
        ),
      ),
    );
  }
}
