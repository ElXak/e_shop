import 'package:flutter/material.dart';

class Product {
  final int id;
  final String title, description;
  final List<String> images;
  final List<Color> colors;
  final double rating, price;
  final bool isFavorite, isPopular;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.images,
    @required this.colors,
    @required this.price,
    this.rating = 0.0,
    this.isFavorite = false,
    this.isPopular = false,
  });
}

// Demo Products

List<Product> demoProducts = [
  Product(
    id: 1,
    title: 'Wireless Controller for PS4',
    description: description,
    images: [
      'assets/images/ps4_console_white_1.png',
      'assets/images/ps4_console_white_2.png',
      'assets/images/ps4_console_white_3.png',
      'assets/images/ps4_console_white_4.png',
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    price: 64.99,
    rating: 4.8,
    isFavorite: true,
    isPopular: true,
  ),
  Product(
    id: 2,
    title: 'Nike Sport White - Man Pant',
    description: description,
    images: [
      'assets/images/Image Popular Product 2.png',
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    price: 50.5,
    rating: 4.1,
    isFavorite: false,
    isPopular: true,
  ),
  Product(
    id: 3,
    title: 'Gloves XC Omega - Polygon',
    description: description,
    images: [
      'assets/images/glap.png',
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    price: 36.55,
    rating: 4.1,
    isFavorite: true,
    isPopular: true,
  ),
  Product(
    id: 4,
    title: 'Logitech Head',
    description: description,
    images: [
      'assets/images/wireless headset.png',
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    price: 20.20,
    rating: 4.1,
    isFavorite: true,
    isPopular: false,
  ),
];

const String description =
    'Wireless Controller for PS4 gives you what you want in your gaming from over precision control your game to sharing...';
