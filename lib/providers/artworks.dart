import 'package:flutter/foundation.dart';
import '../models/artwork.dart';
import '../models/museum.dart';

final List<Artwork> _artworks = [];

class Artworks with ChangeNotifier {
  List<Artwork> _artworks = [
    Artwork(
      id: '1',
      name: 'Mystic Marriage of St Catherine with the Young Baptist and other Saints',
      description: 'The attribution to the great Sienese artist has never been doubted, and indeed the panel’s high quality confirms it. The refined and dreamlike chromatic modulations are typical of the artist, and this work is generally dated to between 1528 and 1535. The magnificent painting has retained its beautiful Renaissance frame. The panel was in the Aldobrandini collection by 1603 and Olimpia Aldobrandini brought it as part of her dowry when she married Prince Camillo Pamphilj.',
      author: 'DOMENICO BECCAFUMI',
      imageUrl: 'https://www.doriapamphilj.it/wp-content/uploads/2019/01/ADP-Fc-672-Ph-Alessandro-Vasari.jpg',
    ),
  ];
}
