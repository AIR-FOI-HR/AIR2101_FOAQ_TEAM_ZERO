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
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: Icon(
                    Icons.person,
                    size: 20,
                    color: Theme.of(context).highlightColor,
                  ),
                ),
                TextSpan(
                    text: artwork.author,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).highlightColor,
                      fontWeight: FontWeight.bold
                    )),
              ],
            ),
          ),
        ),
        // header: GridTileBar(
        //   trailing: Container(
        //     padding: EdgeInsets.all(5),
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(5),
        //       color: Colors.black.withOpacity(0.7),
        //     ),
        //     child: Text(
        //       '${artwork.name}',
        //       style: TextStyle(
        //         fontSize: 18,
        //         color: Theme.of(context).highlightColor,
        //         fontWeight: FontWeight.bold
        //       ),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
