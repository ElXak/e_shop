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

class Cart extends InheritedWidget {
  Cart({
    Key key,
    @required Widget child,
  })  : assert(child != null),
        super(key: key, child: child);

// Demo data for Cart
  final List<CartItem> cartItems = [
    CartItem(product: demoProducts[0], numOfItems: 2),
    CartItem(product: demoProducts[1], numOfItems: 1),
    CartItem(product: demoProducts[3], numOfItems: 1),
  ];

  void removeItem(index) {
    cartItems.removeAt(index);
  }

  static Cart of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<Cart>();

  @override
  bool updateShouldNotify(Cart old) => cartItems != old.cartItems;
}
