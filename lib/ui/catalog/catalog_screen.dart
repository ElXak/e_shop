import 'package:flutter/material.dart';

import '../../enums.dart';
import '../components/custom_bottom_nav_bar.dart';
import '../components/only_search_app_bar.dart';

class CatalogScreen extends StatefulWidget {
  static String routeName = '/catalog';

  @override
  _CatalogScreenState createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OnlySearchAppBar(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.catalog),
    );
  }
}
