import 'package:flutter/material.dart';

import '../../../utils/size_config.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'popular_products.dart';
import 'special_offers.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(height: getProportionateScreenHeight(20)),
            // SearchField(),
            SizedBox(height: getProportionateScreenWidth(10)),
            DiscountBanner(
              //TODO routeName:
              routeName: null,
            ),
            Categories(),
            SpecialOffers(),
            SizedBox(height: getProportionateScreenWidth(30)),
            PopularProducts(),
            SizedBox(height: getProportionateScreenWidth(30)),
          ],
        ),
      ),
    );
  }
}
