import 'package:flutter/material.dart';

import 'search_field.dart';

class OnlySearchAppBar extends StatelessWidget with PreferredSizeWidget {
  const OnlySearchAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: SearchField(),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(100);
}
