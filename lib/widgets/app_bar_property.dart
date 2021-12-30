// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

AppBar appBarProperty({String title, BuildContext context}) {
  return AppBar(
    leading: Builder(
      builder: (BuildContext context) {
        return IconButton(
          icon: const Icon(Icons.menu),
          iconSize: 40,
          color: Theme.of(context).primaryColor,
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        );
      },
    ),
    leadingWidth: 50,
    backgroundColor: Colors.white,
    title: Text(
      title,
      style: Theme.of(context).textTheme.headline6,
    ),
    actions: <Widget>[
      IconButton(
        color: Theme.of(context).primaryColor,
        icon: const Icon(Icons.login),
        iconSize: 40,
        tooltip: 'Go to login screen',
        onPressed: () {
          // handle the press
        },
      ),
    ],
    bottomOpacity: 0.0,
    elevation: 0.0,
  );
}
