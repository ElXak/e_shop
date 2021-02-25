import 'package:flutter/material.dart';

import '../../../utils/size_config.dart';

class RoundedIconBtn extends StatelessWidget {
  const RoundedIconBtn({
    Key key,
    @required this.icon,
    @required this.onPress,
    this.showShadow = false,
  }) : super(key: key);

  final IconData icon;
  final GestureTapCallback onPress;
  final bool showShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenWidth(40),
      width: getProportionateScreenWidth(40),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          if (showShadow)
            BoxShadow(
              offset: Offset(0, 6),
              blurRadius: 10,
              color: Theme.of(context).shadowColor,
            ),
        ],
      ),
      child: FlatButton(
        padding: EdgeInsets.zero,
        // color: Colors.white,
        color: Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        onPressed: onPress,
        child: Icon(icon),
      ),
    );
  }
}
