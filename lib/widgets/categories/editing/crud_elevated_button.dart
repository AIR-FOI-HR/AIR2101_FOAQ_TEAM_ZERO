import 'package:flutter/material.dart';

class CrudElevatedButton extends StatelessWidget {
  final String title;
  final Function onPressConfig;

  CrudElevatedButton(this.title, this.onPressConfig);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).highlightColor,
      ),
      onPressed: onPressConfig,
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline3,
      ),
    );
  }
}
