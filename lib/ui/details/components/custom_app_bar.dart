import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/size_config.dart';

class CustomAppBar extends PreferredSize {
  final double rating;

  CustomAppBar({@required this.rating});

  @override
  // AppBar().preferredSize.height provide the height that apply on AppBar
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          top: getProportionateScreenWidth(10),
          left: getProportionateScreenWidth(20),
          right: getProportionateScreenWidth(20),
        ),
        // EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: getProportionateScreenWidth(40),
              width: getProportionateScreenWidth(40),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  side: BorderSide(
                      color: Theme.of(context).scaffoldBackgroundColor),
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60),
                  ),
                ),
                onPressed: () => Navigator.pop(context),
                child: SvgPicture.asset(
                  "assets/icons/Back ICon.svg",
                  height: 15,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Text(
                    '$rating',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 5),
                  SvgPicture.asset('assets/icons/Star Icon.svg'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
