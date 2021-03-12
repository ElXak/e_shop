import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../utils/size_config.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: SizeConfig.screenWidth * 0.8,
      width: double.infinity,
      height: 40,
      decoration: BoxDecoration(
        color: kSecondaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        style: TextStyle(fontSize: 14),
        onChanged: (value) {
          //TODO Search value
          print(value);
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: 'Search product',
          prefixIcon: Icon(
            Icons.search,
            size: 18,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: getProportionateScreenWidth(10),
          ),
        ),
      ),
    );
  }
}
