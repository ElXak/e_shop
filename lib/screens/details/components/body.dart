import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/Product.dart';
import '../../../size_config.dart';
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
                child: ColorDots(product: product),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class ColorDots extends StatefulWidget {
  const ColorDots({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Product product;

  @override
  _ColorDotsState createState() => _ColorDotsState();
}

class _ColorDotsState extends State<ColorDots> {
  int selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        children: List.generate(
          widget.product.colors.length,
          (index) => ColorDot(
            color: widget.product.colors[index],
            isSelected: selectedColor == index,
            onPress: () {
              setState(() {
                selectedColor = index;
              });
            },
          ),
        ),
      ),
    );
  }
}

class ColorDot extends StatelessWidget {
  const ColorDot({
    Key key,
    @required this.color,
    this.isSelected = false,
    this.onPress,
  }) : super(key: key);

  final Color color;
  final bool isSelected;
  final GestureTapCallback onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: EdgeInsets.only(right: 2),
        padding: EdgeInsets.all(8),
        height: getProportionateScreenWidth(40),
        width: getProportionateScreenWidth(40),
        decoration: BoxDecoration(
          // color: product.colors[0],
          shape: BoxShape.circle,
          border: Border.all(
              color: isSelected ? kPrimaryColor : Colors.transparent),
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
