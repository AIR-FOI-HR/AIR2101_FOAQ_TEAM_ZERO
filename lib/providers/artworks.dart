import 'package:flutter/foundation.dart';
import '../models/artwork.dart';
import '../models/museum.dart';
import '../providers/museums.dart';

class Artworks with ChangeNotifier {
  // final Museums museums = Museums();
  // final List<Museum> museumsList = null;

  // Artworks(){
  //   final List<Museum> museumsList = museums.getMuseums;
  // }

  List<Artwork> _artworks = [
    Artwork(
        id: '1',
        name:
            'Mystic Marriage of St Catherine with the Young Baptist and other Saints',
        description:
            'The attribution to the great Sienese artist has never been doubted, and indeed the panel’s high quality confirms it. The refined and dreamlike chromatic modulations are typical of the artist, and this work is generally dated to between 1528 and 1535. The magnificent painting has retained its beautiful Renaissance frame. The panel was in the Aldobrandini collection by 1603 and Olimpia Aldobrandini brought it as part of her dowry when she married Prince Camillo Pamphilj.',
        author: 'DOMENICO BECCAFUMI',
        imageUrl:
            'https://www.doriapamphilj.it/wp-content/uploads/2019/01/ADP-Fc-672-Ph-Alessandro-Vasari.jpg',
        museum: '2'),
    Artwork(
        id: '2',
        name:
            'Landscape with Ford',
        description:
            '',
        author: 'DOMENICHINO',
        imageUrl:
            'https://www.doriapamphilj.it/wp-content/uploads/2019/01/palazzo-doria-pamphilj-domenichino-paesaggio-con-guado-big.jpg',
        museum: '2'),
    Artwork(
        id: '3',
        name:
            'Dido',
        description:
            '',
        author: 'DOSSO DOSSI',
        imageUrl:
            'https://www.doriapamphilj.it/wp-content/uploads/2019/01/palazzo-doria-pamphilj-didone-big.jpg',
        museum: '2'),
    Artwork(
        id: '4',
        name:
            'The Birth of the Virgin',
        description:
            '',
        author: 'GIOVANNI DI PAOLO DI GRAZIA',
        imageUrl:
            'https://www.doriapamphilj.it/wp-content/uploads/2019/01/palazzo-doria-pamphilj-nascita-della-vergine-big.jpg',
        museum: '2'),
  ];

  List<Artwork> get getArtworks {
    return [..._artworks];
  }
}
