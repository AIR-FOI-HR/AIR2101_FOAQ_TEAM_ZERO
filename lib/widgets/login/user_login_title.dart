import 'package:flutter/material.dart';
import './box_decoration_property.dart';

class UserLoginTitle extends StatelessWidget {
  final String title;
  final BoxConstraints constraints;

  UserLoginTitle(this.title, this.constraints);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context);
    return Container(
      width: double.infinity,
      height: constraints.maxHeight * 0.15,
      decoration: boxDecoration(context, color.primaryColor),
      child: Center(
        child: Text(
          title,
          style: color.textTheme.headline2,
        ),
      ),
    );
  }
}
