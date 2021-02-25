import 'package:flutter/material.dart';

import 'social_card.dart';

class SocialRow extends StatelessWidget {
  const SocialRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialCard(
          icon: 'assets/icons/google-icon.svg',
          onPress: () {
            //TODO Add google authorization API
          },
        ),
        SocialCard(
          icon: 'assets/icons/facebook-2.svg',
          onPress: () {
            //TODO Add facebook authorization API
          },
        ),
        SocialCard(
          icon: 'assets/icons/twitter.svg',
          onPress: () {
            //TODO Add twitter authorization API
          },
        ),
      ],
    );
  }
}
