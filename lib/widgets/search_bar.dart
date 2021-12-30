// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
      padding: EdgeInsets.fromLTRB(20, 5, 10, 5),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        border: Border.all(
          color: Color.fromRGBO(19, 92, 97, 1),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.search),
          Container(
            width: 300,
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
