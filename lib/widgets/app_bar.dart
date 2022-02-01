import 'package:flutter/material.dart';
import 'package:museum_app/models/user.dart';
import '../screens/login/login_screen.dart';
import '../firebase_managers/auth_methods.dart';

void logOut() async {
  await AuthMethods().signOut();
}

AppBar appBar(String title, BuildContext ctx, Color color, User user) {
  print(user);
  return AppBar(
    title: Text(title),
    backgroundColor: color,
    actions: (title != 'Login' && title != 'Registration')
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
                    icon: const Icon(Icons.logout_sharp),
                    iconSize: 40,
                    tooltip: 'Log out',
                    onPressed: () {
                      logOut();
                      Navigator.of(ctx)
                          .pushReplacementNamed(LoginScreen.routeName);
                    },
                  )
          ]
        : null,
  );
}
