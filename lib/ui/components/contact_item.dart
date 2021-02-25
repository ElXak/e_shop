import 'package:e_shop/constants.dart';
import 'package:flutter/material.dart';

class ContactItem extends StatelessWidget {
  const ContactItem({
    Key key,
    @required this.icon,
    @required this.title,
    this.onPress,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Row(
        children: [
          Icon(
            icon,
            // color: Theme.of(context).primaryColor,
            color: kPrimaryColor,
          ),
          SizedBox(width: 10),
          Text(title),
        ],
      ),
    );
  }
}
