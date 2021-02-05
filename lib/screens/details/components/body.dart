import 'package:flutter/material.dart';

import '../../../size_config.dart';
import '../../../models/Product.dart';
import '../../../components/default_button.dart';
import 'color_dots.dart';
import 'product_description.dart';
import 'product_images.dart';
import 'top_rounded_container.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    //TODO SingleScroller for screen or PageView for images
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: ProductImages(product: product),
        ),
        Expanded(
          flex: 6,
          child: SingleChildScrollView(
            child: TopRoundedContainer(
              color: Colors.white,
              child: Column(
                children: [
                  ProductDescription(
                    product: product,
                    onPressSeeMore: () {
                      //TODO Show more description
                    },
                  ),
                  TopRoundedContainer(
                    color: Color(0xFFF6F7F9),
                    child: Column(
                      children: [
                        ColorDots(product: product),
                        TopRoundedContainer(
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: SizeConfig.screenWidth * 0.15,
                              right: SizeConfig.screenWidth * 0.15,
                              top: getProportionateScreenWidth(15),
                              bottom: getProportionateScreenWidth(30),
                            ),
                            child: DefaultButton(
                              text: 'Add to cart',
                              onPress: () {
                                //TODO add to Cart
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
