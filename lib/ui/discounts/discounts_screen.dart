import 'package:flutter/material.dart';

import '../../enums.dart';
import '../components/custom_bottom_nav_bar.dart';

class DiscountsScreen extends StatefulWidget {
  static String routeName = '/discounts';

  @override
  _DiscountsScreenState createState() => _DiscountsScreenState();
}

class _DiscountsScreenState extends State<DiscountsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // iconTheme: IconThemeData(color: kPrimaryColor),
        leadingWidth: 40,
        centerTitle: false,
        title: Text('Список актуалных скидок и акций'),
      ),
      bottomNavigationBar:
          CustomBottomNavBar(selectedMenu: MenuState.discounts),
    );
  }
}
