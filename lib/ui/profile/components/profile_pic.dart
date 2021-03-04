import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key key,
  }) : super(key: key);

  void _changeAvatar() {
    //TODO change picture
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: SizedBox(
        height: 115,
        width: 115,
        child: Stack(
          fit: StackFit.expand,
          overflow: Overflow.visible,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: () => _changeAvatar(),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/Profile Image.png'),
              ),
            ),
            Positioned(
              right: -12,
              bottom: 0,
              child: SizedBox(
                height: 46,
                width: 46,
                child: FlatButton(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(
                        color: Theme.of(context).scaffoldBackgroundColor),
                  ),
                  color: Theme.of(context).buttonColor,
                  onPressed: () => _changeAvatar(),
                  child: SvgPicture.asset('assets/icons/Camera Icon.svg'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
