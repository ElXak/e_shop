import 'package:flutter/material.dart';

import '../../../utils/size_config.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    Key key,
    @required this.title,
    @required this.onPress,
  }) : super(key: key);

  final String title;
  final GestureTapCallback onPress;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onPress,
            child: Text(
              title,
              style: TextStyle(
                fontSize: getProportionateScreenWidth(18),
                color: Colors.black,
              ),
            ),
          ),
          GestureDetector(
            onTap: onPress,
            child: Text(
              'See More',
              style: TextStyle(color: Color(0xFFBBBBBB)),
            ),
          ),
        ],
      ),
    );
  }
}
