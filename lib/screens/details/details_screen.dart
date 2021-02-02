import 'package:flutter/material.dart';

import '../../models/Product.dart';
import 'components/custom_app_bar.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = '/details';

  @override
  Widget build(BuildContext context) {
    final ProductDetailsArguments arguments =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      // By default background color is white
      backgroundColor: Color(0xFFF5F6F9),
      appBar: CustomAppBar(arguments.product.rating),
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
