// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: 80,
            child: DrawerHeader(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.arrow_back_ios),
                    iconSize: 30,
                  ),
                  Container(
                    child: Text(
                      'Museum',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 5, 30, 5),
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: ListTile(
              title: Text(
                'Categories',
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center,
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 5, 30, 5),
            height: 40,
            decoration: BoxDecoration(
              color: Color.fromRGBO(19, 92, 97, 1),
              border: Border.all(
                color: Color.fromRGBO(19, 92, 97, 1),
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: ListTile(
              title: Text(
                'Map',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 5, 30, 5),
            height: 40,
            decoration: BoxDecoration(
              color: Color.fromRGBO(19, 92, 97, 1),
              border: Border.all(
                color: Color.fromRGBO(19, 92, 97, 1),
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: ListTile(
              title: Text(
                'About us',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ),
        ],
      ),
    );
  }
}
