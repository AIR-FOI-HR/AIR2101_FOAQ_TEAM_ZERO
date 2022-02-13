// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:museum_app/firebase_managers/db_caller.dart';
import 'package:museum_app/models/user.dart';
import 'package:museum_app/providers/users.dart';
import 'package:provider/provider.dart';

import '../../models/artwork.dart';

class ArtworkGridItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context);
    User appUser = Provider.of<Users>(context, listen: false).getUser();

    final artwork = Provider.of<Artwork>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: GridTile(
        child: Image.network(
            artwork.imageUrl != ''
                ? artwork.imageUrl
                : 'https://bitsofco.de/content/images/2018/12/broken-1.png',
            fit: BoxFit.cover),
        header: buildHeader(context, artwork, color, appUser),
        footer: buildFooter(context, artwork, color),
      ),
    );
  }

  Widget buildHeader(
      BuildContext context, Artwork artwork, ThemeData color, User appUser) {
    return Container(
      //maybe have another screen where we display artwork info
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            artwork.author,
            softWrap: true,
            style: TextStyle(
              color: color.highlightColor,
              backgroundColor: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 13,
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
                color: color.highlightColor,
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
