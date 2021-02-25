import 'package:e_shop/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'contact_item.dart';

class CustomDrawerHeader extends StatefulWidget {
  @override
  _CustomDrawerHeaderState createState() => _CustomDrawerHeaderState();
}

class _CustomDrawerHeaderState extends State<CustomDrawerHeader> {
  final String _phone = '+992 900 080611';
  final String _email = 'mailbox@lamode.tj';

  Future<void> _launched;

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Uri _emailLaunchUri = Uri(
        scheme: 'mailto',
        path: _email,
        queryParameters: {'subject': 'Example Subject & Symbols are allowed!'});

    return DrawerHeader(
      margin: EdgeInsets.only(bottom: 0),
      padding: EdgeInsets.fromLTRB(16, 0, 16, 8),
      decoration: BoxDecoration(
/*
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: AssetImage('assets/images/Pattern Success.png'),
                ),
*/
          ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 50,
                child: Image.asset('assets/images/shoes2.png'),
              ),
              SizedBox(width: 10),
              Text(
                'Lamode.TJ',
                style: TextStyle(
                  // color: Theme.of(context).primaryColor,
                  color: kPrimaryColor,
                  fontSize: 36,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          ContactItem(
            icon: Icons.phone,
            title: _phone,
            onPress: () => setState(() {
              _launched = _makePhoneCall('tel:$_phone');
            }),
          ),
          ContactItem(
            icon: Icons.email,
            title: _email,
            onPress: () => launch(_emailLaunchUri.toString()),
          ),
        ],
      ),
    );
  }
}
