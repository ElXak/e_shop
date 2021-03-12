import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/size_config.dart';
import 'categories_data.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          categories.length,
          (index) => CategoryCard(
            icon: categories[index]['icon'],
            text: categories[index]['text'],
            //TODO category routeName instead null
            onPress: () => Navigator.pushNamed(
              context,
              null,
              // Pass product to details screen
              arguments: categories[index]['id'],
            ),
/*
            onPress: () {
              print(categories[index]['id']);
            },
*/
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key key,
    @required this.icon,
    @required this.text,
    @required this.onPress,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: SizedBox(
        width: getProportionateScreenWidth(55),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(15)),
              height: getProportionateScreenWidth(55),
              width: getProportionateScreenWidth(55),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight,
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(
                icon,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(height: 5),
            Text(text, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
