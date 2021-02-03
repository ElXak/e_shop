import 'package:flutter/material.dart';

import '../../../models/Product.dart';
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
    return Column(
      children: [
        ProductImages(product: product),
        TopRoundedContainer(
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
                child: Row(),
              )
            ],
          ),
        ),
      ],
    );
  }
}
