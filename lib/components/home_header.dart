import 'package:flutter/material.dart';

import '../size_config.dart';
import '../screens/cart/cart_screen.dart';
import '../models/CartItem.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cartItems = Cart.of(context).cartItems;

    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SearchField(),
          IconBtnWithCounter(
            svgSrc: 'assets/icons/Cart Icon.svg',
            numOfItems: cartItems.length,
            onPress: () => Navigator.pushNamed(context, CartScreen.routeName),
          ),
          IconBtnWithCounter(
            svgSrc: 'assets/icons/Bell.svg',
            numOfItems: 3,
            //TODO Notifications routeName instead null
            onPress: () => Navigator.pushNamed(context, null),
          ),
        ],
      ),
    );
  }
}
