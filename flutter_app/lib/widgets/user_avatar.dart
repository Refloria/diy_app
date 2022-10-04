// user_avatar.dart
import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String _defaultPic = 'images/default_user_pic.jpeg';
  final String picUrl;
  final double radius;
  final double borderWidth;
  final Color borderColor;
  final GestureTapCallback onTap;
  const UserAvatar({
    Key key,
    this.radius = 15,
    this.picUrl,
    this.borderWidth = 0,
    this.borderColor = Colors.white,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = radius + radius;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: width,
        decoration: BoxDecoration(
          border: Border.all(width: borderWidth, color: borderColor),
          borderRadius: BorderRadius.circular(radius),
        ),
        child: ClipOval(
          child: FadeInImage(
            fit: BoxFit.cover,
            placeholder: AssetImage(_defaultPic),
            image:
                picUrl == null ? AssetImage(_defaultPic) : NetworkImage(picUrl),
            fadeOutDuration: Duration(milliseconds: 10),
            fadeInDuration: Duration(milliseconds: 10),
          ),
        ),
      ),
    );
  }
}
