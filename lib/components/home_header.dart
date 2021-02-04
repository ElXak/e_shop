import 'dart:async';

import 'package:flutter/material.dart';

import '../size_config.dart';
import '../models/CartItem.dart';
import '../screens/cart/cart_screen.dart';
import 'icon_btn_with_counter.dart';
import 'search_field.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({
    Key key,
  }) : super(key: key);

  @override
  _HomeHeaderState createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SearchField(),
          IconBtnWithCounter(
            svgSrc: 'assets/icons/Cart Icon.svg',
            numOfItems: demoCart.length,
            onPress: () => Navigator.pushNamed(context, CartScreen.routeName)
                .then(onGoBack),
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

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }
}
