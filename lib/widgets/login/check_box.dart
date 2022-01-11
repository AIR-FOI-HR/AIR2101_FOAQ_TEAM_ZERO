import 'package:flutter/material.dart';

class CheckBox extends StatefulWidget {
  @override
  _CheckBoxState createState() => _CheckBoxState();
}

class _CheckBoxState extends State<CheckBox> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.5,
      child: Checkbox(
          fillColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
          value: isChecked,
          onChanged: (_) {
            setState(() {
              isChecked = !isChecked;
            });
          }),
    );
  }
}
