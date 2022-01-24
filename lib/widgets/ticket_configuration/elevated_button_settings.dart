import 'package:flutter/material.dart';

class ElevatedButtonSetings extends StatelessWidget {
  final String title;
  final Function buttonFunction;

  ElevatedButtonSetings(this.title, this.buttonFunction);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context);
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(color.buttonColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
      ),
      onPressed: buttonFunction,
      child: FittedBox(
        child: Text(
          title,
          style: color.textTheme.headline1,
        ),
      ),
    );
  }
}
