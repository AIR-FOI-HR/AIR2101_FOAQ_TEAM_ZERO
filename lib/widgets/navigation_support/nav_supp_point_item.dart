import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/museum_halls.dart';
import './fhoto_gallery.dart';

import '../../providers/artworks.dart';

class NavSuppPointItem extends StatelessWidget {
  final MuseumHalls museumHallsData;

  NavSuppPointItem(this.museumHallsData);

  @override
  Widget build(BuildContext context) {
    final artworkList = Provider.of<Artworks>(context)
        .getArtworksByMuseumIdAndCategory(
            categoryId: museumHallsData.categoryId,
            museumId: museumHallsData.museumId);
    return Column(
      children: [
        if (museumHallsData.description != null &&
            museumHallsData.description != '')
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            child: Text(
              museumHallsData.description ?? 'No description',
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
          ),
        ComplicatedImageDemo(artworkList),
      ],
    );
  }
}
