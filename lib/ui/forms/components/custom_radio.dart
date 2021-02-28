import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../data/classes/Gender.dart';

class CustomRadio extends StatelessWidget {
  final Gender gender;
  final int position;

  CustomRadio({this.gender, this.position});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 120,
      alignment: Alignment.center,
      margin: position == 0
          ? EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 1)
          : EdgeInsets.only(top: 5, bottom: 5, right: 5),
      decoration: BoxDecoration(
        color: gender.isSelected ? kPrimaryColor : Colors.white,
        borderRadius: position == 0
            ? BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              )
            : BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            gender.icon,
            color: gender.isSelected ? Colors.white : Colors.grey,
            size: 20,
          ),
          SizedBox(width: 10),
          Text(
            gender.name,
            style: TextStyle(
                color: gender.isSelected ? Colors.white : Colors.grey),
          )
        ],
      ),
    );
  }
}
