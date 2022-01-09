import 'package:flutter/material.dart';
import 'package:museum_app/models/artwork.dart';
import 'package:provider/provider.dart';

import '../../providers/artworks.dart';
import './artwork_grid_item.dart';

class ArtworksGrid extends StatelessWidget {
  //this widget gets museum id so we can find that artworks that belong to this museum
  final museumId;
  ArtworksGrid(this.museumId);

  @override
  Widget build(BuildContext context) {
    print(museumId);
    final museumArtworks = Provider.of<Artworks>(context)
        .getByMuseumId(museumId); //access to museum artworks
    return !museumArtworks.isEmpty
        ? GridView.builder(
            shrinkWrap: true, //remove this if search is fixed
            physics:
                const NeverScrollableScrollPhysics(), //remove this if search is fixed
            padding: const EdgeInsets.all(10),
            itemCount: museumArtworks.length,
            itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
              value: museumArtworks[i],
              child: ArtworkGridItem(),
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 3 / 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
          )
        : Image.asset('assets/images/NoArtworks.png',fit: BoxFit.fill,); 
  }
}
