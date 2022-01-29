// ignore_for_file: prefer_final_fields

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
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
        museum: '2',
        category: 'c10'),
    Artwork(
        id: '2',
        name: 'Landscape with Ford',
        description: '',
        author: 'DOMENICHINO',
        imageUrl:
            'https://www.doriapamphilj.it/wp-content/uploads/2019/01/palazzo-doria-pamphilj-domenichino-paesaggio-con-guado-big.jpg',
        museum: '2',
        category: 'c11'),
    Artwork(
        id: '3',
        name: 'Dido',
        description: '',
        author: 'DOSSO DOSSI',
        imageUrl:
            'https://www.doriapamphilj.it/wp-content/uploads/2019/01/palazzo-doria-pamphilj-didone-big.jpg',
        museum: '2',
        category: 'c11'),
    Artwork(
        id: '4',
        name: 'The Birth of the Virgin',
        description: '',
        author: 'GIOVANNI DI PAOLO DI GRAZIA',
        imageUrl:
            'https://www.doriapamphilj.it/wp-content/uploads/2019/01/palazzo-doria-pamphilj-nascita-della-vergine-big.jpg',
        museum: '2',
        category: 'c11'),
    Artwork(
        id: '5',
        name: 'Self-portrait',
        description:
            'In overall good condition, the painting probably has a funereal theme, suggested by the finger pointing to the ring. ',
        author: 'LORENZO LOTTO',
        imageUrl:
            'https://www.doriapamphilj.it/wp-content/uploads/2019/01/palazzo-doria-pamphilj-lotto-lorenzo-autoritratto-big2.jpg',
        museum: '2',
        category: 'c11'),
    Artwork(
        id: '6',
        name: 'Lamentation over the Dead Christ',
        description:
            'The most convincing hypothesis, despite the uncertainties stemming from the existence of several variants of the same subject, identifies the painting in Brera with the “foreshortened Christ” found in Mantegna’s studio at the time of his death, sold by his son Ludovico to Cardinal Sigismondo Gonzaga and inventoried among the property of the lords of Mantua in 1627.',
        author: 'Andrea Mantegna',
        imageUrl:
            'https://pinacotecabrera.org/wp-content/uploads/2014/10/Mantegna-Cristo-Morto-600x498.jpg',
        museum: '5',
        category: 'c11'),
    Artwork(
        id: '7',
        name: 'St. Mark Preaching in Alexandria',
        description:
            'The huge canvas adorned the reception room of the Scuola Grande di San Marco in Venice, one of the city’s most prestigious and powerful confraternities. It was commissioned from Gentile Bellini in 1504 but was left incomplete on the death of the artist in 1507.',
        author: 'Gentile Bellini and Giovanni Bellini',
        imageUrl:
            'https://pinacotecabrera.org/wp-content/uploads/2014/09/Gio-GeBellini-Predica-san-marco-piazza-egitto-600x273.jpg',
        museum: '5',
        category: 'c11'),
    Artwork(
        id: '8',
        name: 'The Marriage of the Virgin',
        description:
            'he painting, dating from 1504, was moved from the Church of San Francesco in Città di Castello to the Pinacoteca in 1805. Raphael painted the Marriage of the Virgin having in mind the altarpiece with the same subject by Perugino, which is conserved at the Musée des Beaux-Arts in Caen. Raphael took inspiration from it, using its composition structure and iconography to obtain a result of incredible and unachievable perfection.',
        author: 'Raffaello Sanzio (Raphael)',
        imageUrl:
            'https://pinacotecabrera.org/wp-content/uploads/2014/09/82_Raffaello_Spozalizio_-418x600.jpg',
        museum: '5',
        category: 'c11'),
    Artwork(
        id: '9',
        name: 'Figurine of Ahmose-Nefertari',
        description:
            'Figurine of Ahmose-Nefertari. The name and titles of this deified queen were likely inscribed on the base, which is missing. Deir el-Medina. New Kingdom, 18th–20th dynasties (1539–1076 BCE).',
        author: 'Unknown',
        imageUrl:
            'https://www.historymuseum.ca/wp-content/uploads/2021/03/ahmose-nefertari-museo-egizio.jpg',
        museum: '6',
        category: 'c6'),
    Artwork(
        id: '10',
        name: 'The Sphinx',
        description: '',
        author: 'Unknown',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/Museo_Egizio_di_Torino-631_o.jpg/1280px-Museo_Egizio_di_Torino-631_o.jpg',
        museum: '6',
        category: 'c6'),
    Artwork(
        id: '11',
        name: 'Egyptian dancer',
        description: '',
        author: 'Unknown',
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/9/98/Female_topless_egyption_dancer_on_ancient_ostrakon.jpg/1024px-Female_topless_egyption_dancer_on_ancient_ostrakon.jpg',
        museum: '6',
        category: 'c6'),
  ];
  final urlArtworks = Uri.parse(
      'https://museumapp-3725f-default-rtdb.europe-west1.firebasedatabase.app/artworks.json');

  //List<Artwork> _artworks = [];

  List getCategoryFromMuseum(String museumId) {
    var _categoryList = [];
    List<Artwork> _museumAllArtworks = _artworks
        .where((artworkData) => artworkData.museum == museumId)
        .toList();

    for (int i = 0; i < _museumAllArtworks.length; i++) {
      _categoryList.add(_museumAllArtworks[i].category);
    }
    return _categoryList.toSet().toList();
  }

  List<Artwork> get getArtworks {
    return [..._artworks];
  }

  Future<void> fetchAndSetArtworks() async {
    try {
      final response = await http.get(urlArtworks);
      final extracedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Artwork> loadedArtworks = [];
      extracedData.forEach((id, artwork) {
        print('Dohvacam artwork');
        loadedArtworks.add(Artwork(
            id: id,
            category: artwork['category'],
            imageUrl: artwork['imageUrl'],
            museum: artwork['museum'],
            name: artwork['name'],
            author: artwork['author'],
            description: artwork['description'],
            isFavorite: false));
      });
      _artworks = loadedArtworks;
    } catch (error) {
      throw (error);
    }
  }

  List<Artwork> getByMuseumId(String id) {
    try {
      fetchAndSetArtworks();
    } catch (error) {
      throw (error);
    }
    return _artworks.where((artwork) => artwork.museum == id).toList();
  }

  List<Artwork> getByCategory(String categoryId) {
    return _artworks
        .where((artwork) => artwork.category == categoryId)
        .toList();
  }

  Artwork getById(String id) {
    try {
      fetchAndSetArtworks();
    } catch (error) {
      throw (error);
    }
    return _artworks.firstWhere((artwork) => artwork.id == id);
  }

  // List<Artwork> getByCategory(String categoryId) {
  //   try {
  //     fetchAndSetArtworks();
  //   } catch (error) {
  //     throw (error);
  //   }
  //   return _artworks
  //       .where((artwork) => artwork.category == categoryId)
  //       .toList();
  // }

  Future<void> addArtwork(Artwork artwork) async {
    try {
      final response = await http.post(urlArtworks,
          body: json.encode({
            'name': artwork.name,
            'imageUrl': artwork.imageUrl,
            'description': artwork.description,
            'author': artwork.author,
            'museum': artwork.museum,
            'category': artwork.category
          }));

      final newArtwork = Artwork(
        category: artwork.category,
        museum: artwork.museum,
        name: artwork.name,
        author: artwork.author,
        description: artwork.description,
        imageUrl: artwork.imageUrl,
        id: json.decode(response.body)['name'],
      );

      print('New artwork: ' + json.decode(response.body)['name']);
      _artworks.add(newArtwork);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> updateArtwork(String id, Artwork newArtwork) async {
    final artworkIndex = _artworks.indexWhere((artwork) => artwork.id == id);
    if (artworkIndex >= 0) {
      try {
        final url = Uri.parse(
            'https://museumapp-3725f-default-rtdb.europe-west1.firebasedatabase.app/artworks/$id.json');
        await http.patch(url,
            body: json.encode({
              'author': newArtwork.author,
              'category': newArtwork.category,
              'description': newArtwork.description,
              'imageUrl': newArtwork.imageUrl,
              'museum': newArtwork.museum,
              'name': newArtwork.name
            }));
        _artworks[artworkIndex] = newArtwork;
        notifyListeners();
      } catch (error) {
        throw error;
      }
    } else {}
  }

  Future<void> deleteArtwork(String id) {
    //to do -> optimistic deletion and error handling
    final url = Uri.parse(
        'https://museumapp-3725f-default-rtdb.europe-west1.firebasedatabase.app/artworks/$id.json');
    http.delete(url);
    _artworks.removeWhere((artwork) => artwork.id == id);
    notifyListeners();
  }
}
