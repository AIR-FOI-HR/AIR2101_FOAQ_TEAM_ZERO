import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/artwork.dart';
import '../models/museum.dart';
import '../providers/museums.dart';

class Artworks with ChangeNotifier {
  final urlArtworks = Uri.parse(
      'https://museumapp-3725f-default-rtdb.europe-west1.firebasedatabase.app/artworks.json');
  List<Artwork> _artworks = [];

  List<Artwork> get getArtworks {
    return [..._artworks];
  }

  Future<void> fetchAndSetArtworks() async {
    try {
      final response = await http.get(urlArtworks);
      final extracedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Artwork> loadedArtworks = [];
      print('Baza: ' + extracedData.length.toString());
      print('Lokalno: ' + _artworks.length.toString());
      if (extracedData.length == _artworks.length) {
        return;
      }
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

  Artwork getById(String id) {
    try {
      fetchAndSetArtworks();
    } catch (error) {
      throw (error);
    }
    return _artworks.firstWhere((artwork) => artwork.id == id);
  }

  List<Artwork> getByCategory(String categoryId) {
    return _artworks
        .where((artwork) => artwork.category == categoryId)
        .toList();
  }

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
