import 'package:flutter/material.dart';

import '../../../size_config.dart';
import '../../../components/home_header.dart';
import 'discount_banner.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenWidth(20)),
            HomeHeader(),
            SizedBox(height: getProportionateScreenWidth(20)),
            DiscountBanner(),
          ],
        ),
      ),
    );
  }
}
