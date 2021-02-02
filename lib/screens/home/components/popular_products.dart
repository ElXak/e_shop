import 'package:flutter/material.dart';

import '../../../size_config.dart';
import '../../../models/Product.dart';
import '../../../components/product_card.dart';
import '../../details/details_screen.dart';
import 'section_title.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(
            title: 'Popular Product',
            onPress: () {
              //TODO Go to More Popular Products
            }),
        SizedBox(
          height: getProportionateScreenWidth(20),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...List.generate(
                demoProducts.length,
                (index) {
                  if (demoProducts[index].isPopular)
                    return ProductCard(
                      product: demoProducts[index],
                      onPress: () => Navigator.pushNamed(
                        context,
                        DetailsScreen.routeName,
                        // Pass product to details screen
                        arguments: ProductDetailsArguments(
                          product: demoProducts[index],
                        ),
                      ),
                    );

                  return SizedBox.shrink(); // by default width and height are 0
                },
              ),
              SizedBox(width: getProportionateScreenWidth(20))
            ],
          ),
        ),
      ],
    );
  }
}
