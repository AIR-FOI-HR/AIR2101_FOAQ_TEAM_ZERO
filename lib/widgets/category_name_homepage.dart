// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CategoryNameHomepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraint) {
        return Container(
          height: constraint.maxHeight,
          margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
          padding: EdgeInsets.fromLTRB(20, 5, 10, 5),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Container(
            width: double.infinity,
            child: Center(
              child: FittedBox(
                child: Text(
                  'Newest Artwork',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
