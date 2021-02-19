import 'package:flutter/material.dart';

import '../../data/classes/Product.dart';
import 'components/body.dart';
import 'components/custom_app_bar.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = '/details';

  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments args =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      // By default background color is white
      backgroundColor: Theme.of(context).buttonColor,

      appBar: CustomAppBar(rating: args.product.rating),
/*
          AppBar(
        backgroundColor: Colors.transparent,
        // Default leading doesn't have enough space
        // We will create our own CustomAppBar
        leading: Padding(
          padding: EdgeInsets.only(left: 20),
          child: RoundedIconBtn(
            iconData: Icons.arrow_back_ios,
            onPress: () => Navigator.pop(context),
          ),
        ),
      ),
*/
      body: Body(product: args.product),
    );
  }
}

// Arguments class for receiving product via named Route
class ProductDetailsArguments {
  final Product product;

  ProductDetailsArguments({
    @required this.product,
  });
}
