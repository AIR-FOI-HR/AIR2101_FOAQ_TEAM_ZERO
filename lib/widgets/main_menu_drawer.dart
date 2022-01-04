// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class MainMenuDrawer extends StatelessWidget {
  Widget createDrawerTile(BuildContext ctx, String name, IconData icon) {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 5, 30, 5),
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(icon),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  name,
                  style: Theme.of(ctx).textTheme.headline5,
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          // Update the state of the app.
          // ...
        },
      ),
    );
  }

  Widget createDivider = Divider(
    color: Colors.black,
    height: 10,
    thickness: 1,
  );
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).primaryColor,
      child: ListView(
        children: [
          Container(
            height: 60,
            color: Theme.of(context).primaryColor,
            child: DrawerHeader(
              padding: EdgeInsets.fromLTRB(15, 5, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton.icon(
                      style: ButtonStyle(alignment: Alignment.centerLeft),
                      onPressed: () {},
                      icon: Icon(
                        Icons.home_outlined,
                        size: 30,
                        color: Colors.white,
                      ),
                      label: Text('Main menu',
                          style: Theme.of(context).textTheme.headline6),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      size: 25,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.white,
            height: 10,
            thickness: 3,
            endIndent: 50,
          ),
          createDrawerTile(context, 'Categories', Icons.account_tree_outlined),
          createDivider,
          createDrawerTile(context, 'Map', Icons.map_outlined),
          createDivider,
          createDrawerTile(
              context, 'About us', Icons.quick_contacts_mail_outlined),
        ],
      ),
    );
  }
}
