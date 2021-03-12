import 'dart:async';

import 'package:flutter/material.dart';

import '../../data/classes/CartItem.dart';
import '../../enums.dart';
import '../cart/cart_screen.dart';
import '../components/app_drawer.dart';
import '../components/custom_bottom_nav_bar.dart';
import '../components/search_field.dart';
import 'components/body.dart';
import 'components/icon_btn_with_counter.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _selectedTabIndex = 0;

  List<Widget> tabsList = [
    Tab(text: 'Женщинам'),
    Tab(text: 'Мужчинам'),
    Tab(text: 'Обувь'),
    Tab(text: 'Аксессуары'),
    Tab(text: 'Образы'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabsList.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedTabIndex = _tabController.index;
      });
      print('Selected Index: ${_tabController.index.toString()}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
/*
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          )
        ],
      ),
*/
      appBar: AppBar(
        // iconTheme: IconThemeData(color: kPrimaryColor),
        leadingWidth: 40,
        centerTitle: false,
        leading: Builder(
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              ),
            );
          },
        ),
        title: SearchField(),
        actions: [
          IconBtnWithCounter(
            buttonSize: 40,
            svgSrc: 'assets/icons/Cart Icon.svg',
            numOfItems: demoCart.length,
            onPress: () => Navigator.pushNamed(context, CartScreen.routeName)
                .then(onGoBack),
          ),
          SizedBox(width: 4),
          IconBtnWithCounter(
            buttonSize: 40,
            svgSrc: 'assets/icons/Heart Icon.svg',
            numOfItems: 3,
            //TODO Favorites routeName instead null
            onPress: () => Navigator.pushNamed(context, null),
          ),
          SizedBox(width: 8),
        ],
        bottom: TabBar(
          onTap: (index) {
            // Should not used it as it only called when tab options are clicked,
            // not when user swapped
          },
          controller: _tabController,
          tabs: tabsList,
          isScrollable: true,
        ),
      ),
      drawer: AppDrawer(),
      body: TabBarView(
        controller: _tabController,
        children: [
          Body(),
          Body(),
          Body(),
          Body(),
          Body(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }
}
