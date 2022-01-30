import 'package:flutter/material.dart';

class ElevatedButtonMyReservation extends StatelessWidget {
  final String title;
  final Function buttonFunction;

  ElevatedButtonMyReservation(
    this.title,
    this.buttonFunction,
  );

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context);
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(color.highlightColor),
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
          style: color.textTheme.headline4,
        ),
      ),
    );
    ;
  }
}
