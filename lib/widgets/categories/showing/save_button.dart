import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).highlightColor,
      onPressed: () {
        Navigator.of(context).pushReplacementNamed('/');
      },
      elevation: 5,
      child: Icon(
        Icons.save,
        size: 40,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
