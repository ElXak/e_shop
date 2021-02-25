import 'package:flutter/material.dart';

import '../../../constants.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({
    Key key,
    @required this.icon,
    @required this.title,
    @required this.subtitle,
    @required this.value,
    @required this.onChange,
  }) : super(key: key);

  final IconData icon;
  final String title, subtitle;
  final bool value;
  final Function onChange;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: kPrimaryColor,
        size: 40,
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Switch.adaptive(
        activeColor: kPrimaryColor,
        inactiveTrackColor: kSecondaryColor,
        value: value,
        onChanged: onChange,
      ),
    );
  }
}
