// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/artwork.dart';

class ArtworkGridItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final artwork = Provider.of<Artwork>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: GridTile(
        child: Image.network(artwork.imageUrl, fit: BoxFit.cover),
        header: Container(
          //maybe have another screen where we display artwork info
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                artwork.author,
                softWrap: true,
                style: TextStyle(
                  color: Theme.of(context).highlightColor,
                  backgroundColor: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              Consumer<Artwork>(
                builder: (ctx, artwork, child) => IconButton(
                  onPressed: () {
                    artwork.toggleFavorite();
                  },
                  icon: Icon(
                    artwork.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Theme.of(context).accentColor,
                    size: 30,
                  ),
                ),
              )
            ],
          ),
        ),
        footer: Container(
          padding: EdgeInsets.all(10),
          color: Colors.black54,
          child: Row(
            children: [
              Flexible(
                child: Text(
                  artwork.name,
                  softWrap: true,
                  style: TextStyle(
                    color: Theme.of(context).highlightColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
