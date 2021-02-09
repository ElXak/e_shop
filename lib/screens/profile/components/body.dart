import 'package:flutter/material.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';
import '../../settings/settings_screen.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfilePic(),
        SizedBox(height: 20),
        ProfileMenu(
          icon: 'assets/icons/User Icon.svg',
          text: 'My Account',
          onPress: () {
            //TODO Go to my account
          },
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
            //TODO Log out
          },
        ),
      ],
    );
  }
}
