import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/models/auth.dart';
import 'custom_drawer_header.dart';
import '../forms/complete_profile_screen.dart';

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
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text(
                '${_auth.user.firstName} ${_auth.user.lastName}',
                maxLines: 1,
              ),
              subtitle: Text(
                _auth.user.id.toString(),
                maxLines: 1,
              ),
              onTap: () {},
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
