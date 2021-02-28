import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Gender {
  String name;
  IconData icon;
  bool isSelected;

  Gender({this.name, this.icon, this.isSelected});
}

Map<String, Gender> genders = {
  'Male': Gender(name: 'Male', icon: FontAwesomeIcons.mars, isSelected: false),
  'Female':
      Gender(name: 'Female', icon: FontAwesomeIcons.venus, isSelected: false),
};
