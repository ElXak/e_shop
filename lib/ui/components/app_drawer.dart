import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../data/models/auth.dart';
import 'custom_drawer_header.dart';
import '../forms/complete_profile_screen.dart';
import '../settings/settings_screen.dart';
import '../splash/splash_screen.dart';
import 'drawer_item.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthModel>(context, listen: true);

    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            CustomDrawerHeader(),
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).shadowColor,
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/images/Profile Image.png'),
              ),
              accountName: Text(
                '${_auth.user.firstName} ${_auth.user.lastName}',
                maxLines: 1,
              ),
              accountEmail: Text(_auth.user.email, maxLines: 1),
              onDetailsPressed: () =>
                  Navigator.pushNamed(context, CompleteProfileScreen.routeName),
            ),
            DrawerItem(
              leading: SvgPicture.asset(
                'assets/icons/Bell.svg',
                width: 20,
                color: kPrimaryColor,
              ),
              title: 'Notifications',
              subtitle: ' (5)',
              onPress: () {
                //TODO: go to My Notifications
              },
            ),
            DrawerItem(
              leading: SvgPicture.asset(
                'assets/icons/Chat bubble Icon.svg',
                width: 20,
                color: kPrimaryColor,
              ),
              title: 'Massages',
              subtitle: ' (5)',
              onPress: () {
                //TODO: go to My Messages
              },
            ),
            DrawerItem(
              leading: SvgPicture.asset('assets/icons/Bill Icon.svg'),
              title: 'Your Orders',
              subtitle: ' (5)',
              onPress: () {
                //TODO: go to My Orders
              },
            ),
            DrawerItem(
              leading: SvgPicture.asset('assets/icons/Bill Icon.svg'),
              title: 'Your Lists',
              subtitle: ' (5)',
              onPress: () {
                //TODO: go to My Lists
              },
            ),
            Divider(),
            DrawerItem(
              leading: SvgPicture.asset('assets/icons/Settings.svg'),
              title: 'Settings',
              onPress: () =>
                  Navigator.pushNamed(context, SettingsScreen.routeName),
            ),
            DrawerItem(
              leading: SvgPicture.asset('assets/icons/Log out.svg'),
              title: 'Log Out',
              onPress: () {
                _auth.logout();
                Navigator.pushNamed(context, SplashScreen.routeName);
              },
            ),
            Container(
              padding: EdgeInsets.only(right: 10),
              child: Align(
                alignment: FractionalOffset.bottomRight,
                child: Text('v. 1.0'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
