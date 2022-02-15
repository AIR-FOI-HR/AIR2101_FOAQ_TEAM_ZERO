// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:museum_app/firebase_managers/db_caller.dart';
import 'package:museum_app/models/artwork.dart';
import 'package:museum_app/models/museum.dart';
import 'package:museum_app/models/user.dart';
import 'package:museum_app/providers/museums.dart';
import 'package:museum_app/providers/users.dart';
import 'package:provider/provider.dart';

import '../../screens/museum_detail_screen.dart';

class FavoriteArtoworksGriddItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context);
    User appUser = Provider.of<Users>(context, listen: false).getUser();
    final artwork = Provider.of<Artwork>(context, listen: false);
    final museum =
        Provider.of<Museums>(context, listen: false).getById(artwork.museum);

    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        color: Colors.black.withOpacity(0.7),
        child: GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(MuseumDetailScreen.routeName,
                  arguments: museum.id);
              //on tap we navigate to museum detail and pass museum id as argument
            },
            child: Image.network(artwork.imageUrl, fit: BoxFit.contain),
          ),
          footer: buildFooter(context, artwork, color),
          header: buildHeader(context, artwork, color, appUser, museum),
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context, Artwork artwork, ThemeData color,
      User appUser, Museum museum) {
    return Container(
      //maybe have another screen where we display artwork info
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            museum.name,
            softWrap: true,
            style: TextStyle(
              color: color.highlightColor,
              backgroundColor: Colors.black.withOpacity(0.5),
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          appUser == null
              ? Container()
              : Consumer<Artwork>(
                  builder: (ctx, artwork, child) => IconButton(
                    onPressed: () async {
                      artwork.toggleFavorite();
                      if (appUser.favoriteArtworks.contains(artwork.id)) {
                        appUser.favoriteArtworks.remove(artwork.id);
                        await DBCaller.updateUser(appUser);
                      } else {
                        appUser.favoriteArtworks.add(artwork.id);
                        await DBCaller.updateUser(appUser);
                      }
                    },
                    icon: Icon(
                      appUser.favoriteArtworks.contains(artwork.id)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: color.accentColor,
                      size: 30,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget buildFooter(BuildContext context, Artwork artwork, ThemeData color) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.black54,
      child: Row(
        children: [
          Flexible(
            child: Text(
              artwork.name,
              softWrap: true,
              style: TextStyle(
                color: color.accentColor,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
