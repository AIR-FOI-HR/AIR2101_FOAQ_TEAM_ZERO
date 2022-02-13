import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/artworks.dart';
import 'favorite_artwork_grid_item.dart';
import '../../models/artwork.dart';

class FavoriteArtworksGrid extends StatelessWidget {
  List<Artwork> artworks;
  FavoriteArtworksGrid(this.artworks);
  @override
  Widget build(BuildContext context) {
    //access to museums data
    return artworks.isNotEmpty
        ? GridView.builder(
            shrinkWrap: true, //remove this if search is fixed
            physics:
                const NeverScrollableScrollPhysics(), //remove this if search is fixed
            padding: const EdgeInsets.all(10),
            itemCount: artworks.length,
            itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
              value: artworks[i],
              child: FavoriteArtoworksGriddItem(),
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 3 / 2,
              mainAxisSpacing: 10,
            ),
          )
        : Padding(
            padding: EdgeInsets.only(top: 20),
            child: Image.asset(
              'assets/images/NoArtworks.png',
              fit: BoxFit.fill,
            ));
  }
}
