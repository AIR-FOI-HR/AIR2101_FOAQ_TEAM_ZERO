// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:museum_app/screens/about_us.dart';
import 'package:museum_app/screens/artworks/favorite_artworks.dart';
import 'package:museum_app/screens/single_musem_configuration/ticket_crud_screen.dart';
import 'package:museum_app/screens/ticket_validation/ticked_validation_screen.dart';
import 'package:provider/provider.dart';

import '../providers/categories.dart';
import '../screens/artworks/manage_artworks_screen.dart';
import '../screens/categories/category_artwork_screen.dart';
import '../screens/my_profile/my_profile_screen.dart';
import '../screens/single_musem_configuration/single_museum_configuration_screen.dart';
import '../screens/ticket_purchase/ticket_purchase_screen.dart';
import '../screens/navigation_support/navigation_support_screen.dart';
import '../screens/map_screen.dart';
import '../../models/user.dart';
import '../../providers/users.dart';

class MainMenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categoryData = Provider.of<Categories>(context);
    User user = Provider.of<Users>(context).getUser();
    //print(user.userRole);
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
            'Map',
            Icons.map_outlined,
            () {
              Navigator.of(context).pushReplacementNamed(MapScreen.routeName);
            },
          ),
          if (user != null)
            if (int.parse(user.userRole) > 0) ...[
              //Obicni korisnik
              createDivider,
              createDrawerTile(
                context,
                'Favorite artworks',
                Icons.image,
                () {
                  Navigator.of(context)
                      .pushReplacementNamed(FavoriteArtworks.routeName);
                },
              ),
              createDivider,
              createDrawerTile(
                context,
                'My Tickets',
                Icons.receipt_long_outlined,
                () {
                  Navigator.of(context)
                      .pushReplacementNamed(TicketPurchaseScreen.routeName);
                },
              ),
              createDivider,
              createDrawerTile(
                context,
                'Navigation support',
                Icons.assistant_navigation,
                () {
                  Navigator.of(context)
                      .pushReplacementNamed(NavigationSupportScreen.routeName);
                },
              ),
              createDivider,
              createDrawerTile(
                context,
                'My Profile',
                Icons.person_rounded,
                () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MyProfileScreen()),
                    (Route<dynamic> route) => false,
                  );
                },
              ),
              if (int.parse(user.userRole) >= 2 && user.museumId != "") ...[
                //Vlasnik muzeja i moderator vide Museum Configuration
                createDivider,
                createDrawerTile(
                  context,
                  'Museum configuration',
                  Icons.museum_outlined,
                  () {
                    Navigator.of(context).pushReplacementNamed(
                        SingleMuseumConfigurationScreen.routeName);
                  },
                ),
                createDivider,
                createDrawerTile(
                  context,
                  'Ticket validation',
                  Icons.qr_code_scanner,
                  () {
                    Navigator.of(context)
                        .pushReplacementNamed(TicketValidationScreen.routeName);
                  },
                ),
              ],
              if ((int.parse(user.userRole) >= 2 && user.museumId != "") ||
                  int.parse(user.userRole) == 3) ...[
                //System admin, vlasnik muzeja i moderator vide Artworks
                //System admin vidi sve artworke
                //Mod i Vlasnik vide samo od svojeg muzeja
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
              ],
            ],
          createDivider,
          createDrawerTile(
            context,
            'About us',
            Icons.quick_contacts_mail_outlined,
            () {
              Navigator.of(context).pushReplacementNamed(AboutUs.routeName);
            },
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
      ),
    );
  }

  Widget createDivider = Divider(
    color: Colors.black,
    height: 10,
    thickness: 1,
  );
}
