import 'package:flutter/material.dart';

BoxDecoration boxDecoration(BuildContext context, Color color) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(25),
    color: color,
    boxShadow: kElevationToShadow[6],
  );
}
