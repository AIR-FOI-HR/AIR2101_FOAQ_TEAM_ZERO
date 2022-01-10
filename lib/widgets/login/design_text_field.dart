import 'package:flutter/material.dart';
import './box_decoration_property.dart';

class DesignTextField extends StatelessWidget {
  TextField textFieldProperty;
  BoxConstraints constraints;

  DesignTextField(this.textFieldProperty, this.constraints);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: constraints.maxHeight * 0.08,
        padding: EdgeInsets.only(left: 20),
        decoration: boxDecoration(context, Colors.white),
        child: textFieldProperty);
  }
}
