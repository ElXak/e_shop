import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    Key key,
    @required this.title,
    this.subtitle,
    this.leading,
    @required this.onPress,
  }) : super(key: key);

  final String title, subtitle;
  final Widget leading;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: Text.rich(
        TextSpan(
          text: title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.headline5.color,
          ),
          children: [
            TextSpan(
              text: subtitle,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
      onTap: onPress,
    );
  }
}
