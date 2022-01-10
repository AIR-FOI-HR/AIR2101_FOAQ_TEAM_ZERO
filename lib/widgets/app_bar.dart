import 'package:flutter/material.dart';
import '../screens/login/login_screen.dart';

AppBar appBar(String title, BuildContext ctx, Color color) {
  return AppBar(
    title: Text(title),
    backgroundColor: color,
    actions: title != 'Login'
        ? <Widget>[
            IconButton(
              color: Colors.white,
              icon: const Icon(Icons.login),
              iconSize: 40,
              tooltip: 'Go to login screen',
              onPressed: () {
                Navigator.of(ctx).pushReplacementNamed(LoginScreen.routeName);
              },
            ),
          ]
        : null,
  );
}
