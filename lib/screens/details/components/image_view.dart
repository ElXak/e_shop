import 'package:flutter/material.dart';

import '../../../size_config.dart';

class ImageView extends StatelessWidget {
  const ImageView({
    Key key,
    @required this.productId,
    @required this.image,
  }) : super(key: key);

  final int productId;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: SizedBox(
        width: getProportionateScreenWidth(238),
        child: AspectRatio(
          aspectRatio: 1,
          child: Hero(
            tag: productId.toString(),
            child: Image.asset(image),
          ),
        ),
      ),
    );
  }
}
