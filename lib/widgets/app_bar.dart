import 'package:flutter/material.dart';

AppBar appBar(String title, BuildContext ctx, Color color) {
  return AppBar(
    title: Text(title),
    backgroundColor: color,
  );
}
