import 'package:flutter/material.dart';

import '../size_config.dart';

class ScrollingBody extends StatelessWidget {
  const ScrollingBody({
    Key key,
    // this.children,
    this.child,
  }) : super(key: key);

  // final List<Widget> children;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          child: child /*Column(
            children: children,
          )*/
          ,
        ),
      ),
    );
  }
}
