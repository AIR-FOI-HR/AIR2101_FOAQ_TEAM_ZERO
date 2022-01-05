import 'package:flutter/material.dart';

AppBar appBar(String title, BuildContext ctx) {
  return AppBar(
    title: Text(title),
    backgroundColor: Theme.of(ctx).primaryColor,
  );
}
