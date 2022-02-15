import 'package:flutter/material.dart';
import 'package:museum_app/models/user.dart';
import 'package:museum_app/screens/my_profile/my_profile_screen.dart';
import '../screens/login/login_screen.dart';

AppBar appBar(String title, BuildContext ctx, Color color, User user) {
  return AppBar(
    title: Text(title),
    backgroundColor: color,
    actions: (title != 'Login' &&
            title != 'Registration' &&
            title != 'Password reset')
        ? <Widget>[
            user == null
                ? IconButton(
                    color: Colors.white,
                    icon: const Icon(Icons.login_sharp),
                    iconSize: 40,
                    tooltip: 'Go to login screen',
                    onPressed: () {
                      Navigator.of(ctx)
                          .pushReplacementNamed(LoginScreen.routeName);
                    },
                  )
                : IconButton(
                    color: Colors.white,
                    icon: CircleAvatar(
                      backgroundImage: user.userImage == ""
                          ? NetworkImage(
                              "https://thumbs.dreamstime.com/b/default-avatar-profile-icon-vector-social-media-user-image-182145777.jpg")
                          : NetworkImage(user.userImage),
                    ),
                    iconSize: 45,
                    tooltip: 'Log out',
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        ctx,
                        MaterialPageRoute(
                            builder: (context) => MyProfileScreen()),
                        (Route<dynamic> route) => false,
                      );
                    },
                  )
          ]
        : null,
  );
}
