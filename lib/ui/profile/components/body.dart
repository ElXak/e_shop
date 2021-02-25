import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';
import '../../settings/settings_screen.dart';
import '../../forms/complete_profile_screen.dart';
import '../../splash/splash_screen.dart';
import '../../../data/models/auth.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthModel>(context, listen: true);

    return Column(
      children: [
        ProfilePic(),
        ProfileMenu(
          icon: 'assets/icons/User Icon.svg',
          text: 'My Account',
          onPress: () =>
              Navigator.pushNamed(context, CompleteProfileScreen.routeName),
        ),
        ProfileMenu(
          icon: 'assets/icons/Bell.svg',
          text: 'Notifications',
          onPress: () {
            //TODO Go to Notifications
          },
        ),
        ProfileMenu(
          icon: 'assets/icons/Settings.svg',
          text: 'Settings',
          onPress: () => Navigator.pushNamed(context, SettingsScreen.routeName),
        ),
        ProfileMenu(
          icon: 'assets/icons/Question mark.svg',
          text: 'Help Center',
          onPress: () {
            //TODO Go to Help Center
          },
        ),
        ProfileMenu(
          icon: 'assets/icons/Log out.svg',
          text: 'Log Out',
          onPress: () {
            _auth.logout();
            Navigator.pushNamed(context, SplashScreen.routeName);
          },
        ),
      ],
    );
  }
}
