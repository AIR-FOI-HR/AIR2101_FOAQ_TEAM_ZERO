import 'package:flutter/material.dart';

AppBar appBar(String title, BuildContext ctx, Color color) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(fontSize: 20),
    ),
    backgroundColor: color,
  );
}
