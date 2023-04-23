import 'package:flutter/material.dart';
import 'package:frontend/component/name_initials_avatar.dart';
import 'package:frontend/components/profile.dart';

import '../models/user.dart';

class LoginComponent extends StatelessWidget {
  LoginComponent(
      {Key? key, required bool this.isLoggedIn, required User this.user})
      : super(key: key);

  bool isLoggedIn;
  User user;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (isLoggedIn) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProfilePage(user: user)));
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: NameInitialsAvatar(
          user.name,
          size: 42.0,
        ),
      ),
    );
  }
}
