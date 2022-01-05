import 'package:flutter/material.dart';

AppBar appBar(String title, BuildContext ctx) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(fontSize: 20),
    ),
    backgroundColor: Theme.of(ctx).primaryColor,
  );
}
