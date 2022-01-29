import 'package:flutter/material.dart';

Future<dynamic> showErrorDialog(BuildContext context) {
  return showDialog<Null>(
      context: context,
      builder: (ctx) => AlertDialog(
            title: Text(
              'An error occurred!',
              style: TextStyle(color: Colors.black),
            ),
            content: Text('Oops, something went wrong..'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text(
                  'Okay',
                  style: TextStyle(backgroundColor: Colors.white),
                ),
              ),
            ],
          ));
}
