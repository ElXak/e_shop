import 'package:flutter/material.dart';

import 'Product.dart';

class CartItem {
  final Product product;
  final int numOfItems;

  CartItem({
    @required this.product,
    @required this.numOfItems,
  });
}

// Demo data for Cart
List<CartItem> demoCart = [
  CartItem(product: demoProducts[0], numOfItems: 2),
  CartItem(product: demoProducts[1], numOfItems: 1),
  CartItem(product: demoProducts[3], numOfItems: 1),
];
