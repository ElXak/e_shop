import 'package:flutter/material.dart';

import '../../models/Product.dart';
import '../../size_config.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = '/details';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // By default background color is white
      backgroundColor: Color(0xFFF5F6F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: RoundedIconBtn(
          iconData: Icons.arrow_back_ios,
          onPress: () => Navigator.pop(context),
        ),
      ),
    );
  }
}

class RoundedIconBtn extends StatelessWidget {
  const RoundedIconBtn({
    Key key,
    @required this.iconData,
    @required this.onPress,
  }) : super(key: key);

  final IconData iconData;
  final GestureTapCallback onPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getProportionateScreenWidth(40),
      width: getProportionateScreenWidth(40),
      child: FlatButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        color: Colors.white,
        onPressed: onPress,
        child: Icon(iconData),
      ),
    );
  }
}

// Arguments class for receiving product via named Route
class ProductDetailsArguments {
  final Product product;

  ProductDetailsArguments({
    @required this.product,
  });
}
