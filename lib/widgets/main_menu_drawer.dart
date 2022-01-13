// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/categories.dart';
import '../screens/artworks/manage_artworks_screen.dart';
import '../screens/categories/category_artwork_screen.dart';

class MainMenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categoryData = Provider.of<Categories>(context);
    return Drawer(
      backgroundColor: Theme.of(context).primaryColorDark,
      child: ListView(
        children: [
          Container(
            height: 60,
            color: Theme.of(context).primaryColorDark,
            child: DrawerHeader(
              padding: EdgeInsets.fromLTRB(15, 5, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton.icon(
                      style: ButtonStyle(alignment: Alignment.centerLeft),
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed('/');
                      },
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
          createDrawerTile(
            context,
            'Categories',
            Icons.account_tree_outlined,
            () {
              categoryData.clearSelectedCategoryList();
              Navigator.of(context)
                  .pushReplacementNamed(CategoryArtworkScreen.routeName);
            },
          ),
          createDivider,
          createDrawerTile(
            context,
            'Artworks',
            Icons.settings_system_daydream,
            () {
              Navigator.of(context)
                  .pushReplacementNamed(ManageArtworksScreen.routeName);
            },
          ),
          createDivider,
          createDrawerTile(
            context,
            'Map',
            Icons.map_outlined,
            () {},
          ),
          createDivider,
          createDrawerTile(
            context,
            'My Profile',
            Icons.supervised_user_circle,
            () {},
          ),
          createDivider,
          createDrawerTile(
            context,
            'About us',
            Icons.quick_contacts_mail_outlined,
            () {},
          ),
        ],
      ),
    );
  }

  Widget createDrawerTile(BuildContext ctx, String name, IconData icon,
      Function drawerTileFunction) {
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
        onTap: drawerTileFunction,
        //() {          Navigator.of(ctx).pushReplacementNamed(routeName);        },
      ),
    );
  }

  Widget createDivider = Divider(
    color: Colors.black,
    height: 10,
    thickness: 1,
  );
}
