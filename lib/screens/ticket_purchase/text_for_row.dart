import 'package:flutter/material.dart';

class TextForRow extends StatelessWidget {
  TextStyle textTheme;
  int expanded;
  String title;

  TextForRow({
    @required this.textTheme,
    @required this.expanded,
    @required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: expanded,
      child: Text(
        title,
        style: textTheme,
      ),
    );
  }
}
