import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';
import '../../../utils/size_config.dart';

class IconBtnWithCounter extends StatelessWidget {
  const IconBtnWithCounter({
    Key key,
    @required this.svgSrc,
    this.numOfItems = 0,
    this.buttonSize = 46,
    @required this.onPress,
  }) : super(key: key);

  final String svgSrc;
  final int numOfItems;
  final double buttonSize;
  final GestureTapCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(8),
      ),
      child: InkWell(
        onTap: onPress,
        borderRadius: BorderRadius.circular(100),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(12)),
              height: getProportionateScreenWidth(buttonSize),
              width: getProportionateScreenWidth(buttonSize),
              decoration: BoxDecoration(
                color: kSecondaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(svgSrc),
            ),
            if (numOfItems != 0)
              Positioned(
                top: -3,
                right: 0,
                child: Container(
                  height: getProportionateScreenWidth(16),
                  width: getProportionateScreenWidth(16),
                  decoration: BoxDecoration(
                    color: Color(0xFFFF4848),
                    shape: BoxShape.circle,
                    border: Border.all(width: 1.5, color: Colors.white),
                  ),
                  child: Center(
                    child: Text(
                      '$numOfItems',
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(10),
                        height: 1,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
